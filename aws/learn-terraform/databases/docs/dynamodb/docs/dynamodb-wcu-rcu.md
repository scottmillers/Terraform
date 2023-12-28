# DynamoDB - Read/Write Capacity Modes

Two modes:

-Provisioned Mode (default)
    - You specify the number of read/writes per second
    - Pay for provisioned read/write capacity units
- On-Demand Mode
    - Read/write capacity automatically scales up or down based on actual usage
    - No capacity planning required
    - Pay for what you use, more expensive ($$$)

You can switch between modes twice in a 24 hour period


## Provisioned Mode

- You specify the number of read/writes per second
- Throughput can be exceeded temporarily using burst credits
- If Burst credits are empty, you get a ProvisionedThroughputExceededException
- Its then advised to do an exponential backoff retry

Write-Capacity Units (WCU)

- 1 WCU = 1 write per second for an item up to 1KB in size
- If items are larger than 1KB, then you need to divide the item size by 1KB and round up to the next integer

Example 1: we write 10 items per second, each item is 2KB in size
    - We need 10 x 2KB / 1KB = 20 WCU
Examples 2: we write 6 items per second, with item size 4.5 KB
    - We need 6 x 5KB / 1KB = 30 WCU
Example 3: we write 120 items per minute, with item size 2 KB
    - We need (120 items/minute) x (1 minute/60 seconds) x 2KB/1KB = 4 WCU

Read-Capacity Units (RCU)

- 1 RCU = 1 strongly consistent read per second, or 2 eventually consistent reads per second, for an item up to 4KB in size
- If the items are larger than 4KB, more RCUs are consumed

Example 1: we need 10 strongly consistent reads each item is 2KB in size
    - We need 10 x 4KB / 4KB = 10 RCU
Example 2: we need 6 eventually consistent reads, each item is 4.5 KB in size
    - We need 6/2 x 8KB / 4KB = 6 RCU
Example 3: 16 eventually consistent reads, each item is 12KB in size
    - We need 16/2 x 12KB / 4KB = 24 RCU
Example 4: 10 strongly consistent reads, each item is 6KB in size
    - We need 10 x 8KB / 4KB = 20 RCU