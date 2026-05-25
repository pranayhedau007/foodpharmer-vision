"""
OCR Quality Predictor CNN.

Predicts the probability that Tesseract OCR will successfully extract
nutrition fields from a given grayscale label image.

Architecture:
    4 conv blocks with BatchNorm, ReLU, MaxPool / AdaptiveAvgPool
    2 fully-connected layers -> Sigmoid
"""

from __future__ import annotations

import torch
import torch.nn as nn


class _ConvBlock(nn.Module):
    def __init__(self, in_ch: int, out_ch: int, pool: nn.Module | None = None):
        super().__init__()
        layers: list[nn.Module] = [
            nn.Conv2d(in_ch, out_ch, 3, padding=1),
            nn.BatchNorm2d(out_ch),
            nn.ReLU(inplace=True),
        ]
        if pool is not None:
            layers.append(pool)
        self.block = nn.Sequential(*layers)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        return self.block(x)


class OCRQualityCNN(nn.Module):
    """
    Predict OCR success probability.

    Input:  (B, 1, 256, 256) grayscale image [0, 1]
    Output: (B, 1) probability in [0, 1]
    """

    def __init__(self, dropout: float = 0.3):
        super().__init__()
        self.features = nn.Sequential(
            _ConvBlock(1, 32, nn.MaxPool2d(2)),      # -> 128x128
            _ConvBlock(32, 64, nn.MaxPool2d(2)),      # -> 64x64
            _ConvBlock(64, 128, nn.MaxPool2d(2)),     # -> 32x32
            _ConvBlock(128, 256, nn.AdaptiveAvgPool2d(4)),  # -> 4x4
        )
        self.classifier = nn.Sequential(
            nn.Flatten(),
            nn.Linear(256 * 4 * 4, 256),
            nn.ReLU(inplace=True),
            nn.Dropout(dropout),
            nn.Linear(256, 1),
            nn.Sigmoid(),
        )

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = self.features(x)
        return self.classifier(x)
