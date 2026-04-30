#!/usr/bin/env python3
"""
@file        scripts/assemble-upload.py
@description Assemble staged upload chunks into one repository file and verify sha256
@rule        Never write outside repository-relative target paths declared in the manifest — path traversal would corrupt the repository
"""

from __future__ import annotations

import argparse
import base64
import hashlib
import json
import sys
from pathlib import Path
from typing import Any


REPO_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_MANIFEST = REPO_ROOT / "staging" / "uploads" / "upload-manifest.json"


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def safe_repo_path(raw_path: str, *, must_be_under: str | None = None) -> Path:
    """Return a safe repository-relative path.

    @section validation
    @important Blocks absolute paths and parent traversal before any write happens.

    Args:
        raw_path: Path from manifest, relative to repository root.
        must_be_under: Optional required top-level prefix such as staging/uploads.

    Returns:
        Absolute resolved path inside the repository.
    """
    if not raw_path or raw_path.startswith("/"):
        fail(f"Unsafe path: {raw_path!r}")

    candidate = (REPO_ROOT / raw_path).resolve()

    try:
        candidate.relative_to(REPO_ROOT)
    except ValueError:
        fail(f"Path escapes repository root: {raw_path!r}")

    if must_be_under:
        required_root = (REPO_ROOT / must_be_under).resolve()
        try:
            candidate.relative_to(required_root)
        except ValueError:
            fail(f"Path must be under {must_be_under}: {raw_path!r}")

    return candidate


def load_manifest(path: Path) -> dict[str, Any]:
    """Load and minimally validate the upload manifest."""
    if not path.exists():
        fail(f"Manifest not found: {path}")

    data = json.loads(path.read_text(encoding="utf-8"))

    required_keys = {"target_path", "sha256", "parts"}
    missing = required_keys - set(data)
    if missing:
        fail(f"Manifest missing keys: {', '.join(sorted(missing))}")

    if not isinstance(data["parts"], list) or not data["parts"]:
        fail("Manifest parts must be a non-empty list")

    encoding = str(data.get("encoding", "utf-8"))
    if encoding not in {"utf-8", "base64"}:
        fail("Manifest encoding must be utf-8 or base64")

    return data


def read_part_bytes(manifest: dict[str, Any]) -> bytes:
    """Read staged parts and return assembled bytes.

    @section assembly
    @important base64 mode exists to make large text uploads safe through APIs that may alter Unicode text payloads.
    """
    encoding = str(manifest.get("encoding", "utf-8"))
    chunks: list[bytes] = []

    for raw_part in manifest["parts"]:
        part_path = safe_repo_path(str(raw_part), must_be_under="staging/uploads")
        if not part_path.exists():
            fail(f"Part file not found: {part_path}")
        chunks.append(part_path.read_bytes())

    raw = b"".join(chunks)
    if encoding == "base64":
        try:
            return base64.b64decode(raw, validate=True)
        except Exception as exc:
            fail(f"Invalid base64 upload parts: {exc}")

    return raw


def assemble(manifest: dict[str, Any]) -> Path:
    """Assemble chunks into target path and verify sha256."""
    target_path = safe_repo_path(str(manifest["target_path"]))
    expected_sha256 = str(manifest["sha256"]).lower().strip()

    if len(expected_sha256) != 64:
        fail("sha256 must be a 64-character hex string")

    target_path.parent.mkdir(parents=True, exist_ok=True)

    data = read_part_bytes(manifest)
    actual_sha256 = hashlib.sha256(data).hexdigest()

    if actual_sha256 != expected_sha256:
        fail(f"sha256 mismatch: expected {expected_sha256}, got {actual_sha256}")

    target_path.write_bytes(data)

    print(f"Assembled {target_path.relative_to(REPO_ROOT)}")
    print(f"sha256 {actual_sha256}")
    return target_path


def main() -> None:
    parser = argparse.ArgumentParser(description="Assemble staged upload chunks")
    parser.add_argument(
        "--manifest",
        default=str(DEFAULT_MANIFEST),
        help="Path to upload manifest relative to repository root or absolute path",
    )
    args = parser.parse_args()

    manifest_path = Path(args.manifest)
    if not manifest_path.is_absolute():
        manifest_path = REPO_ROOT / manifest_path

    manifest = load_manifest(manifest_path.resolve())
    assemble(manifest)


if __name__ == "__main__":
    main()
