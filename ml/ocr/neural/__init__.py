import torch
import torch.nn as nn


def get_device() -> torch.device:
    """Pick the best available device: CUDA > DirectML (AMD) > CPU."""
    if torch.cuda.is_available():
        return torch.device("cuda")
    try:
        import torch_directml
        return torch_directml.device()
    except ImportError:
        return torch.device("cpu")


def load_checkpoint(model: nn.Module, path: str) -> None:
    """
    Load a checkpoint into *model*, handling both raw state_dicts and
    wrapper dicts (keys ``model_state_dict``, ``state_dict``, ``model``).

    Uses ``weights_only=False`` because checkpoints saved on the DirectML
    (privateuseone) device contain custom storage types that the safe
    unpickler rejects.  This is acceptable for locally-generated,
    trusted checkpoints only.
    """
    data = torch.load(path, map_location="cpu", weights_only=False)

    if isinstance(data, dict):
        for key in ("model_state_dict", "state_dict", "model"):
            if key in data:
                data = data[key]
                break

    model.load_state_dict(data)
