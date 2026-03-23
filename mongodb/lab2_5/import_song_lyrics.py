#!/usr/bin/env python3
"""
Import the first 1500 song rows from ~/Downloads/song_lyrics.csv into MongoDB.
Then run transform_data.js with mongosh to normalize features/lyrics.
"""

from __future__ import annotations

import csv
import io
import json
import os
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import Iterator

CSV_PATH = Path.home() / "Downloads" / "song_lyrics.csv"
MONGO_URI = "mongodb://localhost:27017"
DB_NAME = "cbd"
COLLECTION_NAME = "songs"
MAX_ROWS = 1500
TRANSFORM_SCRIPT = Path(__file__).with_name("transform_data.js")


def csv_records(csv_path: Path) -> Iterator[str]:
    """
    Yield complete CSV records (header + rows), correctly handling embedded newlines
    inside quoted fields. Stops only at real record boundaries.
    """
    with csv_path.open("r", encoding="utf-8", errors="replace", newline="") as fh:
        in_quotes = False
        record_chars: list[str] = []

        while True:
            chunk = fh.read(1024 * 1024)
            if not chunk:
                break

            i = 0
            length = len(chunk)
            while i < length:
                ch = chunk[i]
                record_chars.append(ch)

                if ch == '"':
                    nxt = chunk[i + 1] if i + 1 < length else ""
                    if nxt == '"':
                        record_chars.append(nxt)
                        i += 1
                    else:
                        in_quotes = not in_quotes
                elif ch == "\n" and not in_quotes:
                    yield "".join(record_chars)
                    record_chars = []

                i += 1

        if record_chars:
            yield "".join(record_chars)


def parse_record(record: str) -> list[str]:
    reader = csv.reader(
        io.StringIO(record), delimiter=",", quotechar='"', doublequote=True
    )
    return next(reader)


def to_int(value: str, default: int | None = None) -> int | None:
    try:
        return int(value)
    except (TypeError, ValueError):
        return default


def import_first_rows() -> int:
    if not CSV_PATH.exists():
        raise FileNotFoundError(f"CSV file not found: {CSV_PATH}")

    records = csv_records(CSV_PATH)
    header_record = next(records, None)
    if not header_record:
        raise RuntimeError("CSV appears to be empty")

    headers = parse_record(header_record)
    expected = [
        "title",
        "tag",
        "artist",
        "year",
        "views",
        "features",
        "lyrics",
        "id",
        "language_cld3",
        "language_ft",
        "language",
    ]
    if headers[: len(expected)] != expected:
        print("Warning: header does not match expected format exactly", file=sys.stderr)

    docs = []
    for rec_idx, raw_record in enumerate(records, start=1):
        fields = parse_record(raw_record)
        if not fields or all(not f.strip() for f in fields):
            continue

        row = {
            headers[i]: fields[i] if i < len(fields) else ""
            for i in range(len(headers))
        }
        song_id = row.get("id") or f"song_{rec_idx}"

        docs.append(
            {
                "_id": song_id,
                "title": row.get("title", "").strip(),
                "tag": row.get("tag", "").strip(),
                "artist": row.get("artist", "").strip(),
                "year": to_int(row.get("year", ""), None),
                "views": to_int(row.get("views", ""), 0),
                "features": row.get("features", ""),
                "lyrics": row.get("lyrics", ""),
                "language_cld3": row.get("language_cld3", "").strip(),
                "language_ft": row.get("language_ft", "").strip(),
                "language": row.get("language", "").strip(),
            }
        )

        if len(docs) >= MAX_ROWS:
            break

    if not docs:
        raise RuntimeError("No records were parsed from CSV")

    print(f"Clearing existing documents in {DB_NAME}.{COLLECTION_NAME}...")
    clear_cmd = [
        "mongosh",
        "--quiet",
        "--eval",
        f'db.getSiblingDB("{DB_NAME}").getCollection("{COLLECTION_NAME}").deleteMany({{}})',
    ]
    clear_res = subprocess.run(clear_cmd, check=False, text=True, capture_output=True)
    if clear_res.returncode != 0:
        raise RuntimeError(f"Failed to clear collection: {clear_res.stderr.strip()}")

    with tempfile.NamedTemporaryFile(
        mode="w", encoding="utf-8", suffix=".json", delete=False
    ) as tmp:
        json.dump(docs, tmp, ensure_ascii=False)
        tmp_path = tmp.name

    print(f"Inserting {len(docs)} documents with mongoimport...")
    import_cmd = [
        "mongoimport",
        "--uri",
        MONGO_URI,
        "--db",
        DB_NAME,
        "--collection",
        COLLECTION_NAME,
        "--file",
        tmp_path,
        "--jsonArray",
    ]
    import_res = subprocess.run(import_cmd, check=False, text=True, capture_output=True)
    os.unlink(tmp_path)

    if import_res.returncode != 0:
        raise RuntimeError(f"mongoimport failed: {import_res.stderr.strip()}")

    print(import_res.stdout.strip())
    return len(docs)


def run_transform() -> None:
    if not TRANSFORM_SCRIPT.exists():
        raise FileNotFoundError(f"Transform script not found: {TRANSFORM_SCRIPT}")

    print("Running transform_data.js with mongosh...")
    completed = subprocess.run(
        ["mongosh", str(TRANSFORM_SCRIPT)],
        check=False,
        text=True,
    )
    if completed.returncode != 0:
        raise RuntimeError(
            f"transform_data.js failed with exit code {completed.returncode}"
        )


def main() -> None:
    print(f"Reading first {MAX_ROWS} records from: {CSV_PATH}")
    inserted = import_first_rows()
    print(f"Import complete. Documents inserted: {inserted}")

    run_transform()
    print("Normalization complete.")


if __name__ == "__main__":
    main()
