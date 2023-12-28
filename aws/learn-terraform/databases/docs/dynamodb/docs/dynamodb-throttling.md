# DynamoDB - Throttling

- If we exceed the provisioned throughput for a table or a partition, we get a ProvisionedThroughputExceededException

- Reasons
    - Hot keys - one partition key is being read/written too much
    - Hot partitions - one partition is being read/written too much
    - Very large items - RCU and WCU depend on size of items

- Solutions
    - Exponential backoff when exception is encountered (already in SDK)