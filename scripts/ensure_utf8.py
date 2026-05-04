#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path


TEXT_SUFFIXES = {
    ".vue",
    ".js",
    ".ts",
    ".jsx",
    ".tsx",
    ".json",
    ".md",
    ".css",
    ".scss",
    ".less",
    ".html",
    ".xml",
    ".yml",
    ".yaml",
    ".java",
    ".properties",
    ".sql",
    ".txt",
}

# Common legacy encodings seen in mixed Chinese projects.
FALLBACK_ENCODINGS = [
    "utf-8-sig",
    "gb18030",
    "gbk",
    "big5",
    "utf-16",
    "utf-16-le",
    "utf-16-be",
]


def decode_bytes(raw: bytes) -> tuple[str, str] | tuple[None, None]:
    # Fast path: already UTF-8.
    try:
        return raw.decode("utf-8"), "utf-8"
    except UnicodeDecodeError:
        pass

    for enc in FALLBACK_ENCODINGS:
        try:
            return raw.decode(enc), enc
        except UnicodeDecodeError:
            continue

    return None, None


def should_process(path: Path) -> bool:
    if not path.is_file():
        return False
    if path.suffix.lower() in TEXT_SUFFIXES:
        return True
    return False


def convert_file(path: Path, dry_run: bool) -> tuple[bool, str]:
    raw = path.read_bytes()
    text, detected = decode_bytes(raw)
    if text is None:
        return False, "skip: undecodable"

    utf8_bytes = text.encode("utf-8")
    if utf8_bytes == raw and detected == "utf-8":
        return False, "already utf-8"

    if not dry_run:
        path.write_bytes(utf8_bytes)
    return True, f"converted from {detected}"


def main() -> None:
    parser = argparse.ArgumentParser(description="Normalize text files to UTF-8 (no BOM).")
    parser.add_argument(
        "targets",
        nargs="+",
        help="One or more file/directory paths to process recursively.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Only print planned changes.",
    )
    args = parser.parse_args()

    converted = 0
    skipped = 0

    for target in args.targets:
        p = Path(target)
        if not p.exists():
            print(f"[WARN] not found: {p}")
            continue

        paths = [p]
        if p.is_dir():
            paths = list(p.rglob("*"))

        for fp in paths:
            if not should_process(fp):
                continue
            changed, msg = convert_file(fp, dry_run=args.dry_run)
            if changed:
                converted += 1
                print(f"[OK] {fp} -> {msg}")
            else:
                skipped += 1

    mode = "DRY-RUN" if args.dry_run else "DONE"
    print(f"[{mode}] converted={converted}, skipped={skipped}")


if __name__ == "__main__":
    main()

