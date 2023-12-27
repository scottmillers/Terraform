# EFS - Elastic File System

- Managed NFS (Network File System) that can be mounted on many EC2 instances (AZs)
- EFS works with EC2 instances in multi-AZ
- Highly available, scalable, expensive (3x gp2), pay per use, no capacity planning

## Features

- Use cases: content management, web serving, data sharing, Wordpress, etc
- Uses NFSv4.1 protocol
- Uses security groups to control access to EFS
- Compatible with Linux based AMIs (not Windows)
- Encryption at rest using KMS

- POSIX file system (~Linux) that has a standard file API
- File system scales automatically, pay per use, no capacity planning

## EFS - Performance and Storage Classes

- EFS Scale
    - 1000s of concurrent NFS clients, 10 GB+/s throughput
    - Grow to Petabyte-scale network file system, automatically
- Performance Mode (set at EFS creation time)
    - General Purpose (default)
        - Latency-sensitive use cases (web server, CMS, etc)
        - Higher throughput mode for higher latency
    - Max I/O - higher latency, higher throughput, highly parallel (big data, media processing)
- Throughput Mode
    - Bursting (default) - 1TB = 50MiB/s + burst of up to 100MiB/s
    - Provisioned - set your throughput regardless of storage size, ex: 1 GiB/sec for 1 TB storage
    - Elastic - automatically scales throughput up or down based on your workloads
        - Up to 3GiB/s for reads and 1 Gib/s for writes
        - Used for unpredictable workloads

## EFS - Storage Classes

- Storage Tiers (lifecycle management features - move file after N days)
    - Standard : for frequently accessed files
    - Infrequent Access (EFS IA) : cost to retrieve files,  lower price to store. Enable EFS-IA with a lifecycle policy
- Availability and durability
    - Standard: Multi-AZ, great for prod
    - One Zone: One AZ, great for dev, backup enabled by default, compatible with IA (EFS One Zone IA)
- Over 90% in cost savings