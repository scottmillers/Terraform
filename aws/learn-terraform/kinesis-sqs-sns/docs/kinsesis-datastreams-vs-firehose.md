# AWS Kinesis Data Streams vs Firehose

## AWS Kinesis Data Streams

- Streaming service for ingest at scale
- Write custom code (producer/consumer)
- Real-time (~200 ms latency)
- Manage scaling (shard splitting/merging)
- Data storage for 1 to 365 days
- Supports replay capability


## AWS Kinesis Data Firehose

- Load streaming data into S3, Redshift, OpenSearch, 3rd party, custom HTTP
- Fully managed service
- Near real-time (buffer time min 60 seconds)
- Auto scaling
- No data storage
- Doesn't support replay capability
