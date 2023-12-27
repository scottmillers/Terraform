# Hard Disks (Magnetic Volumes)

Magnetic volumes are backed by magnetic drives and are the oldest and slowest type of EBS volume. They are ideal for workloads where data is accessed infrequently and applications where the lowest storage cost is important. Magnetic volumes are suited for:

- Workloads where data is accessed infrequently
- Applications where the lowest storage cost is important

Two types

Throughput Optimized HDD (st1)
- Low-cost magnetic storage that focuses on throughput rather than IOPS.
- Throughput of up to 500 MiB/s
- Subject to throughput credit carps, the available throughput of an st1 volume is expressed by the following formula: (volume size) * (credit balance) / (3000 MiB/s)


Cold HDD (sc1)
- Lowest cost HDD volume designed for less frequently accessed workloads.
- Throughput of up to 250 MiB/s

## References

https://tutorialsdojo.com/amazon-ebs/?src=udemy#types-of-ebs-volumes