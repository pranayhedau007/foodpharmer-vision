"""Train a small image-level OCR quality model for final OCR V2.

The model predicts whether a corrupted nutrition-label image is likely to
produce bad, medium, or good Tesseract/parser field accuracy. Labels are
generated from the existing synthetic corrupted images by running Tesseract,
parsing fields, and comparing against ground truth.
"""

from __future__ import annotations

import argparse
import json
import logging
import random
import re
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any

import cv2
import numpy as np
import pandas as pd
import pytesseract
import torch
import torch.nn as nn
from PIL import Image
from sklearn.metrics import accuracy_score, confusion_matrix, f1_score, roc_auc_score
from torch.utils.data import DataLoader, Dataset

from ..field_confidence_lite import tolerant_value_match
from ..fields import NUTRITION_FIELDS
from ..parse_synthetic_ocr import parse_synthetic_ocr

logger = logging.getLogger(__name__)

TESS_CONFIG = "--oem 3 --psm 11"
CLASS_NAMES = ["bad", "medium", "good"]
CLASS_TO_ID = {name: idx for idx, name in enumerate(CLASS_NAMES)}


@dataclass(frozen=True)
class QualityRecord:
    image_path: str
    image_id: str
    clean_id: str
    severity: int
    correct_fields: int
    total_fields: int
    field_accuracy: float
    quality_label: str
    class_id: int


def _configure_tesseract() -> None:
    candidates = [
        Path(r"C:\Program Files\Tesseract-OCR\tesseract.exe"),
        Path(r"C:\Program Files (x86)\Tesseract-OCR\tesseract.exe"),
    ]
    for candidate in candidates:
        if candidate.exists():
            pytesseract.pytesseract.tesseract_cmd = str(candidate)
            return


def _run_tesseract(img: np.ndarray) -> str:
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    return pytesseract.image_to_string(Image.fromarray(gray), config=TESS_CONFIG)


def _parse_severity(stem: str) -> int:
    match = re.search(r"__sev(\d+)__", stem)
    return int(match.group(1)) if match else 0


def _score_fields(parsed: dict[str, Any], gt: dict[str, Any]) -> tuple[int, int, float]:
    correct = 0
    total = 0
    for field in NUTRITION_FIELDS:
        gt_val = gt.get(field)
        if gt_val is None:
            continue
        total += 1
        if tolerant_value_match(parsed.get(field), gt_val, field):
            correct += 1
    return correct, total, correct / total if total else 0.0


def _label_from_accuracy(acc: float) -> str:
    if acc >= 0.80:
        return "good"
    if acc >= 0.40:
        return "medium"
    return "bad"


def generate_quality_records(
    data_root: Path,
    max_images: int,
    out_dir: Path,
    force_labels: bool = False,
) -> list[QualityRecord]:
    out_dir.mkdir(parents=True, exist_ok=True)
    labels_path = out_dir / "small_vision_quality_label_cache.csv"
    if labels_path.exists() and not force_labels:
        df = pd.read_csv(labels_path)
        if max_images <= 0 or len(df) >= max_images:
            logger.info("Reusing cached OCR quality labels from %s", labels_path)
            if max_images > 0:
                df = df.head(max_images)
            return [
                QualityRecord(
                    image_path=str(row.image_path),
                    image_id=str(row.image_id),
                    clean_id=str(row.clean_id),
                    severity=int(row.severity),
                    correct_fields=int(row.correct_fields),
                    total_fields=int(row.total_fields),
                    field_accuracy=float(row.field_accuracy),
                    quality_label=str(row.quality_label),
                    class_id=int(row.class_id),
                )
                for row in df.itertuples(index=False)
            ]

    meta_dir = data_root / "metadata"
    gt_cache: dict[str, dict[str, Any]] = {}
    for path in sorted(meta_dir.glob("label_*.json")):
        with path.open("r", encoding="utf-8") as fh:
            meta = json.load(fh)
        gt_cache[path.stem] = meta.get("fields", {})

    image_paths = sorted((data_root / "corrupted").glob("*.png"))
    if max_images > 0:
        image_paths = image_paths[:max_images]

    records: list[QualityRecord] = []
    raw_dir = out_dir / "raw_tesseract_examples"
    raw_dir.mkdir(parents=True, exist_ok=True)

    for idx, path in enumerate(image_paths, start=1):
        clean_id = path.stem.split("__")[0]
        gt = gt_cache.get(clean_id)
        if not gt:
            continue
        img = cv2.imread(str(path))
        if img is None:
            continue
        text = _run_tesseract(img)
        if idx <= 30:
            (raw_dir / f"{path.stem}.txt").write_text(text, encoding="utf-8")
        parsed = parse_synthetic_ocr(text)
        correct, total, acc = _score_fields(parsed, gt)
        label = _label_from_accuracy(acc)
        records.append(
            QualityRecord(
                image_path=str(path),
                image_id=path.stem,
                clean_id=clean_id,
                severity=_parse_severity(path.stem),
                correct_fields=correct,
                total_fields=total,
                field_accuracy=acc,
                quality_label=label,
                class_id=CLASS_TO_ID[label],
            )
        )
        if idx % 50 == 0 or idx == len(image_paths):
            logger.info("Generated labels for %d/%d images", idx, len(image_paths))

    pd.DataFrame([record.__dict__ for record in records]).to_csv(labels_path, index=False)
    logger.info("Wrote OCR quality label cache to %s", labels_path)
    return records


def split_records(records: list[QualityRecord], seed: int = 42) -> dict[str, list[QualityRecord]]:
    by_clean: dict[str, list[QualityRecord]] = {}
    for record in records:
        by_clean.setdefault(record.clean_id, []).append(record)

    clean_ids = sorted(by_clean)
    rng = random.Random(seed)
    rng.shuffle(clean_ids)
    n = len(clean_ids)
    n_train = max(1, int(0.70 * n))
    n_val = max(1, int(0.15 * n))
    train_ids = set(clean_ids[:n_train])
    val_ids = set(clean_ids[n_train : n_train + n_val])
    test_ids = set(clean_ids[n_train + n_val :])
    if not test_ids and val_ids:
        moved = sorted(val_ids)[-1]
        val_ids.remove(moved)
        test_ids.add(moved)

    splits = {"train": [], "val": [], "test": []}
    for record in records:
        if record.clean_id in train_ids:
            splits["train"].append(record)
        elif record.clean_id in val_ids:
            splits["val"].append(record)
        else:
            splits["test"].append(record)
    return splits


class QualityImageDataset(Dataset):
    def __init__(self, records: list[QualityRecord], transform: Any) -> None:
        self.records = records
        self.transform = transform

    def __len__(self) -> int:
        return len(self.records)

    def __getitem__(self, idx: int) -> tuple[torch.Tensor, torch.Tensor, int]:
        record = self.records[idx]
        img = Image.open(record.image_path).convert("RGB")
        return self.transform(img), torch.tensor(record.class_id, dtype=torch.long), idx


def _build_transforms(img_size: int):
    from torchvision import transforms

    return transforms.Compose(
        [
            transforms.Resize((img_size, img_size)),
            transforms.ToTensor(),
            transforms.Normalize(
                mean=[0.485, 0.456, 0.406],
                std=[0.229, 0.224, 0.225],
            ),
        ]
    )


def _build_model(backbone: str, num_classes: int) -> nn.Module:
    if backbone != "mobilenet_v3_small":
        raise ValueError("Only --backbone mobilenet_v3_small is implemented for this final pass")

    from torchvision.models import MobileNet_V3_Small_Weights, mobilenet_v3_small

    weights = MobileNet_V3_Small_Weights.DEFAULT
    model = mobilenet_v3_small(weights=weights)
    for param in model.features.parameters():
        param.requires_grad = False
    in_features = model.classifier[-1].in_features
    model.classifier[-1] = nn.Linear(in_features, num_classes)
    return model


def _class_weights(records: list[QualityRecord], device: torch.device) -> torch.Tensor:
    counts = np.bincount([record.class_id for record in records], minlength=len(CLASS_NAMES))
    counts = np.maximum(counts, 1)
    weights = counts.sum() / (len(CLASS_NAMES) * counts)
    return torch.tensor(weights, dtype=torch.float32, device=device)


def _evaluate(
    model: nn.Module,
    loader: DataLoader,
    records: list[QualityRecord],
    device: torch.device,
) -> dict[str, Any]:
    model.eval()
    y_true: list[int] = []
    y_pred: list[int] = []
    probs: list[list[float]] = []
    row_indices: list[int] = []
    with torch.no_grad():
        for images, labels, indices in loader:
            images = images.to(device)
            logits = model(images)
            prob = torch.softmax(logits, dim=1).cpu().numpy()
            pred = prob.argmax(axis=1)
            y_true.extend(labels.numpy().tolist())
            y_pred.extend(pred.tolist())
            probs.extend(prob.tolist())
            row_indices.extend(indices.numpy().tolist())

    labels_present = sorted(set(y_true))
    macro_f1 = f1_score(y_true, y_pred, labels=list(range(len(CLASS_NAMES))), average="macro", zero_division=0)
    acc = accuracy_score(y_true, y_pred) if y_true else 0.0
    cm = confusion_matrix(y_true, y_pred, labels=list(range(len(CLASS_NAMES))))
    auroc_good = None
    if len(set(1 if y == CLASS_TO_ID["good"] else 0 for y in y_true)) == 2:
        auroc_good = roc_auc_score(
            [1 if y == CLASS_TO_ID["good"] else 0 for y in y_true],
            [prob[CLASS_TO_ID["good"]] for prob in probs],
        )

    pred_rows: list[dict[str, Any]] = []
    for local_idx, true_id, pred_id, prob in zip(row_indices, y_true, y_pred, probs):
        record = records[local_idx]
        pred_rows.append(
            {
                "image_path": record.image_path,
                "image_id": record.image_id,
                "clean_id": record.clean_id,
                "severity": record.severity,
                "correct_fields": record.correct_fields,
                "total_fields": record.total_fields,
                "field_accuracy": record.field_accuracy,
                "quality_label": record.quality_label,
                "class_id": true_id,
                "predicted_label": CLASS_NAMES[pred_id],
                "predicted_class_id": pred_id,
                "prob_bad": prob[CLASS_TO_ID["bad"]],
                "prob_medium": prob[CLASS_TO_ID["medium"]],
                "prob_good": prob[CLASS_TO_ID["good"]],
            }
        )

    return {
        "accuracy": float(acc),
        "macro_f1": float(macro_f1),
        "auroc_good_vs_not_good": None if auroc_good is None else float(auroc_good),
        "labels_present": labels_present,
        "confusion_matrix": cm,
        "prediction_rows": pred_rows,
    }


def _threshold_sweep(prediction_rows: list[dict[str, Any]]) -> pd.DataFrame:
    if not prediction_rows:
        return pd.DataFrame(
            columns=[
                "threshold",
                "coverage",
                "accepted_ocr_accuracy",
                "rejected_ocr_accuracy",
                "accepted_good_rate",
                "n_accepted",
                "n_rejected",
            ]
        )
    df = pd.DataFrame(prediction_rows)
    rows: list[dict[str, Any]] = []
    for threshold in [0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.85, 0.90, 0.95]:
        accepted = df[df["prob_good"] >= threshold]
        rejected = df[df["prob_good"] < threshold]
        rows.append(
            {
                "threshold": threshold,
                "coverage": len(accepted) / len(df) if len(df) else 0.0,
                "accepted_ocr_accuracy": accepted["field_accuracy"].mean() if len(accepted) else np.nan,
                "rejected_ocr_accuracy": rejected["field_accuracy"].mean() if len(rejected) else np.nan,
                "accepted_good_rate": (accepted["quality_label"] == "good").mean() if len(accepted) else np.nan,
                "n_accepted": int(len(accepted)),
                "n_rejected": int(len(rejected)),
            }
        )
    return pd.DataFrame(rows)


def train_and_evaluate(args: argparse.Namespace) -> None:
    out_dir = Path(args.out)
    out_dir.mkdir(parents=True, exist_ok=True)
    _configure_tesseract()

    records = generate_quality_records(
        Path(args.data),
        max_images=args.max_images,
        out_dir=out_dir,
        force_labels=args.force_labels,
    )
    if len(records) < 12:
        raise RuntimeError("Not enough labeled images to train/evaluate the vision quality model")

    splits = split_records(records, seed=args.seed)
    for split_name, split_records_list in splits.items():
        logger.info("%s records: %d", split_name, len(split_records_list))

    device = torch.device("cpu" if args.cpu or not torch.cuda.is_available() else "cuda")
    transform = _build_transforms(args.img_size)
    train_ds = QualityImageDataset(splits["train"], transform)
    val_ds = QualityImageDataset(splits["val"], transform)
    test_ds = QualityImageDataset(splits["test"], transform)

    train_loader = DataLoader(train_ds, batch_size=args.batch_size, shuffle=True, num_workers=0)
    val_loader = DataLoader(val_ds, batch_size=args.batch_size, shuffle=False, num_workers=0)
    test_loader = DataLoader(test_ds, batch_size=args.batch_size, shuffle=False, num_workers=0)

    model = _build_model(args.backbone, len(CLASS_NAMES)).to(device)
    criterion = nn.CrossEntropyLoss(weight=_class_weights(splits["train"], device))
    optimizer = torch.optim.AdamW(
        [param for param in model.parameters() if param.requires_grad],
        lr=args.lr,
        weight_decay=1e-4,
        foreach=False,
        fused=False,
    )

    history: list[dict[str, Any]] = []
    best_val_f1 = -1.0
    best_path = out_dir / "small_vision_quality_mobilenet_v3_small.pt"
    start_time = time.perf_counter()

    for epoch in range(1, args.epochs + 1):
        model.train()
        running_loss = 0.0
        for images, labels, _indices in train_loader:
            images = images.to(device)
            labels = labels.to(device)
            optimizer.zero_grad()
            logits = model(images)
            loss = criterion(logits, labels)
            loss.backward()
            optimizer.step()
            running_loss += loss.item() * images.size(0)
        train_loss = running_loss / max(len(train_ds), 1)

        val_metrics = _evaluate(model, val_loader, splits["val"], device)
        val_f1 = float(val_metrics["macro_f1"])
        history.append(
            {
                "epoch": epoch,
                "train_loss": train_loss,
                "val_accuracy": val_metrics["accuracy"],
                "val_macro_f1": val_f1,
            }
        )
        logger.info(
            "Epoch %d/%d train_loss=%.4f val_acc=%.3f val_macro_f1=%.3f",
            epoch,
            args.epochs,
            train_loss,
            val_metrics["accuracy"],
            val_f1,
        )
        if val_f1 >= best_val_f1:
            best_val_f1 = val_f1
            torch.save(model.state_dict(), best_path)

    if best_path.exists():
        model.load_state_dict(torch.load(best_path, map_location=device, weights_only=True))

    test_metrics = _evaluate(model, test_loader, splits["test"], device)
    pred_df = pd.DataFrame(test_metrics["prediction_rows"])
    sweep_df = _threshold_sweep(test_metrics["prediction_rows"])
    cm = test_metrics["confusion_matrix"]

    pred_df.to_csv(out_dir / "small_vision_quality_predictions.csv", index=False)
    sweep_df.to_csv(out_dir / "small_vision_quality_threshold_sweep.csv", index=False)
    pd.DataFrame(cm, index=CLASS_NAMES, columns=CLASS_NAMES).to_csv(
        out_dir / "small_vision_quality_confusion_matrix.csv"
    )
    pd.DataFrame(history).to_csv(out_dir / "small_vision_quality_training_history.csv", index=False)

    all_test_acc = pred_df["field_accuracy"].mean() if not pred_df.empty else 0.0
    best_accept = sweep_df["accepted_ocr_accuracy"].max(skipna=True) if not sweep_df.empty else np.nan
    best_threshold = None
    if not sweep_df.empty and not np.isnan(best_accept):
        best_threshold = float(sweep_df.loc[sweep_df["accepted_ocr_accuracy"].idxmax(), "threshold"])

    class_distribution = {
        split: {
            class_name: int(sum(record.quality_label == class_name for record in split_records_list))
            for class_name in CLASS_NAMES
        }
        for split, split_records_list in splits.items()
    }
    metrics = {
        "model": "torchvision.models.mobilenet_v3_small(weights=DEFAULT)",
        "backbone": args.backbone,
        "img_size": args.img_size,
        "epochs": args.epochs,
        "batch_size": args.batch_size,
        "device": str(device),
        "n_records": len(records),
        "class_names": CLASS_NAMES,
        "class_distribution": class_distribution,
        "test": {
            "n": int(len(test_ds)),
            "classification_accuracy": test_metrics["accuracy"],
            "macro_f1": test_metrics["macro_f1"],
            "auroc_good_vs_not_good": test_metrics["auroc_good_vs_not_good"],
            "all_image_mean_ocr_accuracy": float(all_test_acc),
            "best_threshold_by_accepted_ocr_accuracy": best_threshold,
            "best_accepted_ocr_accuracy": None if np.isnan(best_accept) else float(best_accept),
            "training_seconds": time.perf_counter() - start_time,
        },
        "success_readout": (
            "Accepted images under the best confidence threshold have higher OCR accuracy than all test images."
            if best_threshold is not None and float(best_accept) > float(all_test_acc)
            else "Preliminary image-quality model; no threshold improved accepted OCR accuracy on this small split."
        ),
    }
    (out_dir / "small_vision_quality_metrics.json").write_text(
        json.dumps(metrics, indent=2),
        encoding="utf-8",
    )
    logger.info("Wrote small vision quality artifacts to %s", out_dir)


def main() -> None:
    parser = argparse.ArgumentParser(description="Train MobileNetV3 small OCR quality model")
    parser.add_argument("--data", required=True, help="Synthetic OCR data root")
    parser.add_argument("--out", required=True, help="Output directory")
    parser.add_argument("--max-images", type=int, default=400)
    parser.add_argument("--img-size", type=int, default=224)
    parser.add_argument("--epochs", type=int, default=10)
    parser.add_argument("--batch-size", type=int, default=16)
    parser.add_argument("--backbone", default="mobilenet_v3_small")
    parser.add_argument("--lr", type=float, default=1e-3)
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--cpu", action="store_true")
    parser.add_argument("--force-labels", action="store_true", help="Regenerate Tesseract labels")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    random.seed(args.seed)
    np.random.seed(args.seed)
    torch.manual_seed(args.seed)
    train_and_evaluate(args)


if __name__ == "__main__":
    main()
