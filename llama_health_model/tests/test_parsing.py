import json
import re
import pytest
from llama_health_model.inference import _extract_json

SIMPLE_JSON = '{"health_score": 42, "risk_level": "MEDIUM", "flags": [{"ingredient":"hfcs","reason":"sugar"}], "summary":"Test"}'
WRAPPED_JSON = "Some preface text\n" + SIMPLE_JSON + "\nSome trailing text"
BROKEN_JSON = '{"health_score": 42, "risk_level": "MEDIUM", "flags": [ {"ingredient": "hfcs", "reason": "sugar"} ], "summary": "Test"'
KEY_VALUE_TEXT = """
health_score: 55
risk_level: LOW
flags: hfcs - high sugar
summary: Mostly fine
"""

@pytest.mark.parametrize("raw,expected_score,expected_risk", [
    (SIMPLE_JSON, 42, "MEDIUM"),
    (WRAPPED_JSON, 42, "MEDIUM"),
    (BROKEN_JSON, 42, "MEDIUM"),  # regex extraction should recover the JSON object if possible
    (KEY_VALUE_TEXT, 55, "LOW"),   # heuristic fallback should parse simple key: value lines
])
def test_extract_json_common_cases(raw, expected_score, expected_risk):
    parsed = _extract_json(raw)
    assert isinstance(parsed, dict)
    # health_score may be int or string convertible to int
    hs = parsed.get("health_score")
    assert hs is not None
    # allow numeric or numeric-string
    if isinstance(hs, str):
        assert hs.isdigit()
        hs = int(hs)
    assert int(hs) == expected_score
    rl = parsed.get("risk_level")
    assert isinstance(rl, str)
    assert rl.upper().startswith(expected_risk)

def test_extract_json_returns_minimal_structure_on_failure():
    garbage = "I am not JSON and contain no useful keys"
    parsed = _extract_json(garbage)
    assert isinstance(parsed, dict)
    # fallback should include keys used by the system
    assert "health_score" in parsed
    assert "risk_level" in parsed
    assert "flags" in parsed
    assert "summary" in parsed
