# Database Types

- RDBMS (= SQL/OLTP): RDS, Aurora - great for joins
- NoSQL databases: no joins, no SQL: DynamoDB, Elasticache - great for key-value lookups, Neptune (graph database), DocumentDB (MongoDB compatible), Keyspaces (Cassandra compatible)
- Object store: S3 (for big objects) / Glacier (for backups)
- Data warehouse: (= SQL Analytics/BI): Redshift (OLAP), Athena (serverless, pay per query), EMR
- Search: OpenSearch (JSON) - free text, unstructured searches
- Graphs: Amazon Neptune - highly connected data
- Ledger: Amazon QLDB - immutable, transparent, cryptographically verifiable transaction log
- Time series: Amazon Timestream - IoT, DevOps, Industrial telemetry, application monitoring, geospatial, weather, financial, etc.