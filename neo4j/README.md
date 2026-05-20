# Neo4j

## Starting neo4j

```bash
docker compose up -d
```

### Pass word changes

If you change the password, make sure to delete `data/dbms/auth.ini` and restart the containers.

If that does not work, delete the `neo4j` directory.

