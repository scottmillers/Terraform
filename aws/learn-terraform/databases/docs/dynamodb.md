# Amazon DynamoDB

- AWS proprietary technology, managed serverless NoSQL database, millisecond latency
- Capacity modes: provisioned capacity with optional auto-scaling or on-demand capacity
- Can replace ElasticCache as a key/value store (storing session data for example, using TTL feature)
- Highly Available, Multi-AZ by default, Read and Writes are decoupled, transaction capability
- DAX cluster for read cache, microsecond read latency
- Security, authentication and authorization is done through IAM
- Event Processing: DynamoDB Streams to integrate with AWS Lambda, or Kinesis Data Streams
- Global Table feature: active-active setup
- Automated backups up to 35 days with a PITR (restore to new table), or on-demand backups
- Export to S3 without using RCU within the PITR window, import from S3 without using WCU
- Great for rapidly evolving schemas

- Use Case: Serverless applications development (small documents 100s KB), distributed serverless cache

## Core Components

- Tables: a collection of items
- Items: a collection of attributes
    - DynamoDB uses primary keys to uniquely identify each item in a table and secondary indexes to provide more querying flexibility.
- Attribute: a fundamental data element
- Primary Key: uniquely identifies each item in a table, must be unique, can be partition key or partition key + sort key
    - Partition Key: simple primary key, unique for each item, used to distribute data across partitions
    - Partition Key + Sort Key: composite primary key, composed of two attributes, first is partition key, second is sort key, used to organize data within a partition
- Secondary Index: lets you query the data in the table using an alternate key, in addition to queries against the primary key



References
https://tutorialsdojo.com/amazon-dynamodb/