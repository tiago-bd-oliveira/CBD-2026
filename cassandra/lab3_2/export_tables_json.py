#!/usr/bin/env python3
"""Export all tables from a Cassandra keyspace into <table>.json files.

The script uses the DataStax Cassandra driver and discovers tables from
system_schema.tables (equivalent to DESCRIBE TABLES for automation).
"""

from __future__ import annotations

import argparse
import json
from datetime import date, datetime, time
from decimal import Decimal
from pathlib import Path
from typing import Any
from uuid import UUID

from cassandra.cluster import Cluster
from cassandra.query import SimpleStatement


def to_json_compatible(value: Any) -> Any:
    """Convert Cassandra/Python values into JSON-serializable structures."""
    if value is None:
        return None
    if isinstance(value, (str, int, float, bool)):
        return value
    if isinstance(value, Decimal):
        # Keep precision in JSON as string.
        return str(value)
    if isinstance(value, UUID):
        return str(value)
    if isinstance(value, (datetime, date, time)):
        return value.isoformat()
    if isinstance(value, bytes):
        return value.hex()
    if isinstance(value, dict):
        return {str(k): to_json_compatible(v) for k, v in value.items()}
    if isinstance(value, (list, tuple, set, frozenset)):
        return [to_json_compatible(v) for v in value]
    return str(value)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Export each table in a Cassandra keyspace into <table>.json"
    )
    parser.add_argument("keyspace", help="Cassandra keyspace name")
    parser.add_argument("--host", default="127.0.0.1", help="Cassandra host")
    parser.add_argument("--port", type=int, default=9042, help="Cassandra native port")
    parser.add_argument(
        "--output-dir",
        default=".",
        help="Directory where <table>.json files will be written",
    )
    return parser.parse_args()


def get_tables(session, keyspace: str) -> list[str]:
    stmt = SimpleStatement(
        "SELECT table_name FROM system_schema.tables WHERE keyspace_name = %s"
    )
    rows = session.execute(stmt, [keyspace])
    tables = sorted(row.table_name for row in rows)
    return tables


def export_table(session, keyspace: str, table: str, output_dir: Path) -> None:
    stmt = SimpleStatement(f"SELECT * FROM {keyspace}.{table}")
    rows = session.execute(stmt)

    payload: list[dict[str, Any]] = []
    for row in rows:
        raw = row._asdict()
        payload.append({k: to_json_compatible(v) for k, v in raw.items()})

    out_path = output_dir / f"{table}.json"
    with out_path.open("w", encoding="utf-8") as f:
        json.dump(payload, f, ensure_ascii=False, indent=2)

    print(f"Exported {table} -> {out_path}")


def main() -> int:
    args = parse_args()
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    cluster = Cluster([args.host], port=args.port)
    session = cluster.connect()

    try:
        tables = get_tables(session, args.keyspace)
        if not tables:
            print(f"No tables found in keyspace '{args.keyspace}'.")
            return 1

        for table in tables:
            export_table(session, args.keyspace, table, output_dir)

        print(f"Done. Exported {len(tables)} table(s) from keyspace '{args.keyspace}'.")
        return 0
    finally:
        session.shutdown()
        cluster.shutdown()


if __name__ == "__main__":
    raise SystemExit(main())
