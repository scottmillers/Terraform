# AWS Snowball Edge



![Snowball Edge](images/snowball-edge.png)

- Physical data transport solution: move TBs or PBs of data in or out of AWS
- Alternative to moving data over the network
- Pay per data transfer job
- Provide block storage and Amazon S3-compatible object storage
- Snowball Edge Storage Optimized:
    - 80 TB of HDD capacity for S3 compatible object storage
    - 40 vCPUs and 80GB of memory for use with EC2 compute instances
- Snowball Edge Compute Optimized:
    - Storage: 42 TB of HDD or 28TB NVMe(non-volatile memory express) capacity for block volume and S3 compatible object storage
    - Compute: 104 vCPUs and 416GB of memory and optional GPU for use with EC2 compute instances
    - Storage clustering available (up to 16 nodes)
- Use cases: large data cloud migrations, DC decommission, disaster recovery

## References

https://tutorialsdojo.com/aws-snowball-edge/

https://aws.amazon.com/snowball-edge/features/
https://aws.amazon.com/snowball-edge/pricing/
https://aws.amazon.com/snowball-edge/faqs/
