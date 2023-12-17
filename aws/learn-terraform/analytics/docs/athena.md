# AWS Athena

- An interactive query service that makes it easy to analyze data in Amazon S3 and other data sources using standard SQL.
- Athena is serverless, so there is no infrastructure to manage, and you pay only for the queries that you run.
- Uses Presto, a distributed SQL engine, to run queries.
- Supports a wide variety of data formats, including CSV, JSON, ORC, Avro, and Parquet.
- Integrates with QuickSight for easy data visualization.
- Integrates with AWS Glue Data Catalog, which offers a persistent metadata store for your data in Amazon S3.

## Data Formats

Amazon Athena supports a wide variety of data formats like CSV, TSV, JSON, or Textfiles and also supports open-source columnar formats such as Apache ORC and Apache Parquet. Athena also supports compressed data in Snappy, Zlib, LZO, and GZIP formats. By compressing, partitioning, and using columnar formats you can improve performance and reduce your costs.

Parquet and ORC file formats both support predicate pushdown (also called predicate filtering). Parquet and ORC both have blocks of data that represent column values. Each block holds statistics for the block, such as max/min values. When a query is being executed, these statistics determine whether the block should be read or skipped.

Athena charges you by the amount of data scanned per query. You can save on costs and get better performance if you partition the data, compress data, or convert it to columnar formats such as Apache Parquet.

Apache Parquet is an open-source columnar storage format that is 2x faster to unload and takes up 6x less storage in Amazon S3 as compared to other text formats. One can COPY Apache Parquet and Apache ORC file formats from Amazon S3 to your Amazon Redshift cluster. Using AWS Glue, one can configure and run a job to transform CSV data to Parquet. Parquet is a columnar format that is well suited for AWS analytics services like Amazon Athena and Amazon Redshift Spectrum.


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

## References

https://tutorialsdojo.com/amazon-athena/

https://aws.amazon.com/blogs/big-data/top-10-performance-tuning-tips-for-amazon-athena/

https://docs.aws.amazon.com/lake-formation/latest/dg/access-control-underlying-data.html

https://docs.aws.amazon.com/lake-formation/latest/dg/TBAC-overview.html
