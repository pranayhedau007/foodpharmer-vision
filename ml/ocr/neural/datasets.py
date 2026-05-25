"""
PyTorch datasets for the OCR neural preprocessing pipeline.

The primary dataset loads (corrupted_image, ocr_target_image, metadata)
triples.  Splits are done by *clean label id* (not corrupted image id)
to prevent data leakage.
"""

from __future__ import annotations

import json
import os
import random
from pathlib import Path
from typing import Optional

import cv2
import numpy as np
import torch
from torch.utils.data import Dataset

# ── Split generation ──────────────────────────────────────────────────────────

def generate_splits(data_dir: str, train_ratio: float = 0.70,
                    val_ratio: float = 0.15, seed: int = 42) -> dict[str, list[str]]:
    """
    Split clean label IDs into train / val / test sets.

    Writes split files to ``data_dir/splits/``.
    Returns ``{"train": [...], "val": [...], "test": [...]}``.
    """
    meta_dir = os.path.join(data_dir, "metadata")
    clean_ids = sorted(
        p.stem for p in Path(meta_dir).glob("label_*.json")
    )
    if not clean_ids:
        raise FileNotFoundError(f"No label metadata found in {meta_dir}")

    rng = random.Random(seed)
    rng.shuffle(clean_ids)

    n = len(clean_ids)
    n_train = int(n * train_ratio)
    n_val = int(n * val_ratio)

    splits = {
        "train": clean_ids[:n_train],
        "val": clean_ids[n_train:n_train + n_val],
        "test": clean_ids[n_train + n_val:],
    }

    split_dir = os.path.join(data_dir, "splits")
    os.makedirs(split_dir, exist_ok=True)
    for name, ids in splits.items():
        path = os.path.join(split_dir, f"{name}.txt")
        with open(path, "w") as f:
            f.write("\n".join(ids) + "\n")

    return splits


def load_splits(data_dir: str) -> dict[str, list[str]]:
    """Load previously generated split files."""
    split_dir = os.path.join(data_dir, "splits")
    splits: dict[str, list[str]] = {}
    for name in ("train", "val", "test"):
        path = os.path.join(split_dir, f"{name}.txt")
        if not os.path.exists(path):
            raise FileNotFoundError(f"Split file not found: {path}.  Run generate_splits first.")
        with open(path) as f:
            splits[name] = [line.strip() for line in f if line.strip()]
    return splits


# ── Dataset ───────────────────────────────────────────────────────────────────

class OCRPreprocessDataset(Dataset):
    """
    Dataset of (corrupted, target) image pairs for training the U-Net.

    Each sample is resized to ``(img_size, img_size)`` grayscale,
    normalised to [0, 1] float tensors.
    """

    def __init__(self, data_dir: str, split_ids: list[str],
                 img_size: int = 256,
                 severity_filter: Optional[set[int]] = None,
                 max_samples: int = 0):
        self.data_dir = data_dir
        self.img_size = img_size

        corrupted_dir = os.path.join(data_dir, "corrupted")
        target_dir = os.path.join(data_dir, "clean_targets")

        split_set = set(split_ids)
        self.pairs: list[tuple[str, str, str]] = []  # (corrupted_path, target_path, clean_id)

        if not os.path.isdir(corrupted_dir):
            raise FileNotFoundError(f"Corrupted directory not found: {corrupted_dir}")

        for p in sorted(Path(corrupted_dir).glob("*.png")):
            # Skip neural-preprocessed images
            if "__neural" in p.stem:
                continue
            # e.g. label_000001__sev2__aug03.png  -> clean_id = label_000001
            clean_id = p.stem.split("__")[0]
            if clean_id not in split_set:
                continue
            # Severity filter
            if severity_filter is not None:
                sev = self._parse_severity(p.stem)
                if sev not in severity_filter:
                    continue
            target_path = os.path.join(target_dir, f"{clean_id}.png")
            if not os.path.exists(target_path):
                continue
            self.pairs.append((str(p), target_path, clean_id))

        # Limit sample count
        if max_samples > 0 and len(self.pairs) > max_samples:
            rng = random.Random(42)
            rng.shuffle(self.pairs)
            self.pairs = self.pairs[:max_samples]
            self.pairs.sort()  # deterministic order after sampling

    @staticmethod
    def _parse_severity(stem: str) -> int:
        for part in stem.split("__"):
            if part.startswith("sev"):
                try:
                    return int(part[3:])
                except ValueError:
                    pass
        return 0

    def __len__(self) -> int:
        return len(self.pairs)

    def __getitem__(self, idx: int) -> dict:
        corr_path, tgt_path, clean_id = self.pairs[idx]

        corr = cv2.imread(corr_path, cv2.IMREAD_GRAYSCALE)
        tgt = cv2.imread(tgt_path, cv2.IMREAD_GRAYSCALE)

        corr = cv2.resize(corr, (self.img_size, self.img_size))
        tgt = cv2.resize(tgt, (self.img_size, self.img_size))

        corr_t = torch.from_numpy(corr).float().unsqueeze(0) / 255.0
        # Binarize target: every pixel is strictly 0.0 (text) or 1.0 (background).
        # This gives the BCEWithLogitsLoss clean supervision and forces the model
        # to make hard text-vs-background decisions instead of blurry reconstructions.
        tgt_t = (torch.from_numpy(tgt).float().unsqueeze(0) / 255.0 > 0.5).float()

        return {"input": corr_t, "target": tgt_t, "clean_id": clean_id}


class OCRQualityDataset(Dataset):
    """
    Dataset for training the OCR quality predictor.

    Loads images and their OCR success labels from a CSV.
    """

    def __init__(self, csv_path: str, img_size: int = 256,
                 split_ids: Optional[list[str]] = None,
                 label_column: str = "success_score"):
        import pandas as pd
        self.img_size = img_size
        self.label_column = label_column

        df = pd.read_csv(csv_path)
        if split_ids is not None:
            split_set = set(split_ids)
            df = df[df["clean_id"].isin(split_set)].reset_index(drop=True)

        self.records = df.to_dict("records")

    def __len__(self) -> int:
        return len(self.records)

    def __getitem__(self, idx: int) -> dict:
        row = self.records[idx]
        img_path = row["image_path"]

        img = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
        if img is None:
            img = np.zeros((self.img_size, self.img_size), dtype=np.uint8)
        img = cv2.resize(img, (self.img_size, self.img_size))
        img_t = torch.from_numpy(img).float().unsqueeze(0) / 255.0

        label = float(row[self.label_column])
        label_t = torch.tensor([label], dtype=torch.float32)

        return {"input": img_t, "label": label_t}
