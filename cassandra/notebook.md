# Cassandra Lab

## Instructions

Start cassandra server:
```bash
docker compose up -d
```
Start cqlsh:
```bash
docker exec -it cassandra-dev cqlsh
```

Start cqlsh locally with uv:
```bash
uv run --with cqlsh --python 3.11 cqlsh localhost 9042
```

## Ex 1

### Keyspaces

#### Create keyspace

```sql
CREATE KEYSPACE IF NOT EXISTS cbd 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
```

#### Use keyspace
```sql
USE cbd;
```

#### See available keyspaces

```sql
DESCRIBE KEYSPACES;
```

### Tables / ColumnFamilies

#### List Tables
```sql
DESCRIBE TABLES;
```

#### Create Table
```sql
CREATE TABLE IF NOT EXISTS <table_name> (
    <column_name> <datatype> PRIMARY KEY,
    <column_name> <datatype>
)
```

##### Composite Keys
```sql
{columns...},
PRIMARY KEY (<column1>, <column2>)
```

### Queries

#### Select

```sql
SELECT * FROM <table_name>
```

##### JSON format

```sql
SELECT JSON * FROM <table_name>
```

### Export All Tables To JSON Files

Run the Python exporter (one file per table: `<table_name>.json`):

```bash
uv run --with cassandra-driver --python 3.11 python lab3_2/export_tables_json.py cbd --host localhost --port 9042 --output-dir lab3_2/json
```


