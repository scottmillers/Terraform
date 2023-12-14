# AWS Athena

- An interactive query service that makes it easy to analyze data in Amazon S3 and other data sources using standard SQL.
- Athena is serverless, so there is no infrastructure to manage, and you pay only for the queries that you run.
- Uses Presto, a distributed SQL engine, to run queries.
- Supports a wide variety of data formats, including CSV, JSON, ORC, Avro, and Parquet.
- Integrates with QuickSight for easy data visualization.
- Integrates with AWS Glue Data Catalog, which offers a persistent metadata store for your data in Amazon S3.

## Athena Federated Queries

- Allows you to query data sources other than S3 buckets using a data connector
- A data connector is a Lambda function that uses Athena Query Federation SDK to execute SQL queries against a data source
- There are pre-built data connectors for Amazon RDS, Amazon DocumentDB, Amazon Redshift, and Amazon CloudWatch Logs
- You can also create your own data connectors

## Optimizing query performance

- Data partitioning: Athena uses a technique called partitioning to restrict the amount of data that needs to be read by each query. Partitioning is the process of dividing a table into smaller, more manageable parts based on the values of one or more columns.
- Converting data format into columnar formats such as Parquet or ORC
- Compressing Files
- Making files splittable