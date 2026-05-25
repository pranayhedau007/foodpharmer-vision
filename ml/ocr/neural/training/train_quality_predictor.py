"""
Train the OCR quality predictor CNN.

Usage:
    python -m ml.ocr.neural.training.train_quality_predictor \
        --labels data/synthetic_ocr/metadata/ocr_quality_labels.csv \
        --epochs 20 \
        --out ml/ocr/neural/weights/ocr_quality_cnn.pt
"""

from __future__ import annotations

import argparse
import csv
import logging
import os
import warnings

import torch
import torch.nn as nn
from torch.utils.data import DataLoader

from .. import get_device
from ..datasets import OCRQualityDataset, load_splits
from ..models.ocr_quality_cnn import OCRQualityCNN

logger = logging.getLogger(__name__)

# Suppress DirectML CPU-fallback warnings for unsupported ops
warnings.filterwarnings("ignore", message=".*aten::lerp.*")


def train(labels_csv: str, epochs: int, out_path: str,
          batch_size: int = 128, lr: float = 1e-3,
          data_dir: str | None = None,
          patience: int = 5) -> None:
    device = get_device()
    use_cuda = device.type == "cuda"
    use_gpu = use_cuda or "privateuseone" in str(device)
    logger.info("Device: %s  (GPU=%s)", device, use_gpu)

    # Infer data_dir from labels_csv path if not given
    if data_dir is None:
        # labels_csv is typically data/synthetic_ocr/metadata/ocr_quality_labels.csv
        data_dir = os.path.dirname(os.path.dirname(labels_csv))

    # Load splits
    try:
        splits = load_splits(data_dir)
    except FileNotFoundError:
        from ..datasets import generate_splits
        splits = generate_splits(data_dir)

    train_ds = OCRQualityDataset(labels_csv, split_ids=splits["train"],
                                 label_column="success_score")
    val_ds = OCRQualityDataset(labels_csv, split_ids=splits["val"],
                               label_column="success_score")

    if len(train_ds) == 0:
        raise RuntimeError("Training dataset is empty.  Check labels CSV and splits.")

    logger.info("Train samples: %d  Val samples: %d", len(train_ds), len(val_ds))

    train_loader = DataLoader(train_ds, batch_size=batch_size, shuffle=True,
                              num_workers=0, pin_memory=use_cuda)
    val_loader = DataLoader(val_ds, batch_size=batch_size, shuffle=False,
                            num_workers=0, pin_memory=use_cuda)

    model = OCRQualityCNN().to(device)
    criterion = nn.MSELoss()  # Regression on success_score
    # AdamW with foreach=False avoids aten::lerp that DirectML doesn't support
    optimizer = torch.optim.AdamW(model.parameters(), lr=lr,
                                  foreach=False, fused=False)
    scheduler = torch.optim.lr_scheduler.ReduceLROnPlateau(optimizer, patience=3, factor=0.5)

    weight_dir = os.path.dirname(out_path) or "."
    os.makedirs(weight_dir, exist_ok=True)

    train_log: list[dict] = []
    val_log: list[dict] = []
    best_val_loss = float("inf")
    patience_counter = 0

    for epoch in range(1, epochs + 1):
        # ── Train ──
        model.train()
        running = 0.0
        for batch in train_loader:
            inputs = batch["input"].to(device, non_blocking=True)
            labels = batch["label"].to(device, non_blocking=True)

            optimizer.zero_grad()
            preds = model(inputs)
            loss = criterion(preds, labels)
            loss.backward()
            optimizer.step()
            running += loss.item() * inputs.size(0)

        train_loss = running / len(train_ds)
        train_log.append({"epoch": epoch, "loss": train_loss})

        # ── Validate ──
        model.eval()
        val_running = 0.0
        val_correct_cls = 0
        val_total_cls = 0
        with torch.no_grad():
            for batch in val_loader:
                inputs = batch["input"].to(device, non_blocking=True)
                labels = batch["label"].to(device, non_blocking=True)
                preds = model(inputs)
                val_running += criterion(preds, labels).item() * inputs.size(0)

                # Binary classification accuracy at 0.60 threshold
                pred_good = (preds >= 0.60).long()
                true_good = (labels >= 0.60).long()
                val_correct_cls += (pred_good == true_good).sum().item()
                val_total_cls += labels.size(0)

        val_loss = val_running / max(len(val_ds), 1)
        val_acc = val_correct_cls / max(val_total_cls, 1)
        val_log.append({"epoch": epoch, "loss": val_loss, "accuracy": val_acc})
        scheduler.step(val_loss)

        logger.info("Epoch %d/%d  train_loss=%.5f  val_loss=%.5f  val_acc=%.3f",
                     epoch, epochs, train_loss, val_loss, val_acc)

        # Save best + early stopping
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            patience_counter = 0
            torch.save({k: v.detach().cpu() for k, v in model.state_dict().items()}, out_path)
            logger.info("  -> saved best checkpoint")
        else:
            patience_counter += 1
            if patience_counter >= patience:
                logger.info("Early stopping at epoch %d (no improvement for %d epochs)",
                            epoch, patience)
                break

    # Save last
    last_path = out_path.replace(".pt", "_last.pt")
    torch.save({k: v.detach().cpu() for k, v in model.state_dict().items()}, last_path)

    # Save CSV logs
    log_dir = os.path.join(os.path.dirname(out_path), "..", "outputs", "metrics")
    os.makedirs(log_dir, exist_ok=True)

    with open(os.path.join(log_dir, "predictor_training_loss.csv"), "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["epoch", "loss"])
        writer.writeheader()
        writer.writerows(train_log)

    with open(os.path.join(log_dir, "predictor_validation.csv"), "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["epoch", "loss", "accuracy"])
        writer.writeheader()
        writer.writerows(val_log)

    logger.info("Training complete.  Best val_loss=%.5f", best_val_loss)


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(description="Train OCR quality predictor CNN")
    parser.add_argument("--labels", required=True, help="Path to ocr_quality_labels.csv")
    parser.add_argument("--epochs", type=int, default=20)
    parser.add_argument("--batch-size", type=int, default=128)
    parser.add_argument("--lr", type=float, default=1e-3)
    parser.add_argument("--patience", type=int, default=5,
                        help="Early stopping patience (epochs without improvement)")
    parser.add_argument("--out", required=True, help="Output .pt path")
    parser.add_argument("--data-dir", default=None, help="Root data dir (inferred from --labels if omitted)")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    train(args.labels, args.epochs, args.out,
          batch_size=args.batch_size, lr=args.lr, data_dir=args.data_dir,
          patience=args.patience)


if __name__ == "__main__":
    main()
