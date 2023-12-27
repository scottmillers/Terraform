# AWS EC2 Volume Types

- 3 volume types
    - General Purpose (gp2/gp3)
    - Provisioned IOPS (io1/io2)
    - HDD/Magnetic (st1/sc1)

- EBS volumes are characterized in size | throughput | IOPS (I/O Ops Per Second)

- Only gp2/gp3 and io1/io2 are bootable

## General Purpose SSD (gp2/gp3) volumes

- Cost effective storage, low-latency
- System boot volumes, Virtual desktops, dev/test environments
- Can range in size from 1 GiB to 16 TiB
- gp3:
    - Baseline of 3000IOPS and throughput of 125MiB/s
    - Can increase IOPS up to 16000 and throughput up to 1000MiB/s
- gp2
    - Small gp2 volumes can burst IOPS to 3000
    - Size of the volume and IOPS are linked, max IOPS is 16000
    - 3 IOPS per GiB, means a 5334 GB volume can have 16000 IOPS


## Provisioned IOPS SSD (io1/io2) volumes

- Critical business applications that require sustained IOPS performance
- Or applications that need more than 16,000 IOPS
- Great for database workloads (sensitive to storage perf and consistency)
- io1/io2 (4GiB - 16TiB)
    - Max PIOPS: 64,000 for Nitro EC2 instances and 32,000 for other
    - Can increase IOPS up to 64000 and throughput up to 1000MiB/s
    - io2 has more durability (99.999%) vs io1 (99.9%) and more IOPS per GiB (at the same price as io1)
- io2 Block Express (4 GiB - 64 TiB)
    - Sub-millisecond latency
    - Max PIPS: 256,000 with an IOPS:GiB ratio of 1,000:1
- Supports EBS Multi-sattach (attach to multiple EC2 instances in the same AZ)

# Hard Disk Drives(HDD)

- Cannot be a boot volume
- 125 GiB - 16 TiB
- Throughput Optimized HDD (st1)
    - Big data, data warehouses, log processing
    - Max throughput: 500 MiB/s - max IOPS 500
- Cold HDD (sc1)
    - For data that is infrequently accessed
    - Scenarios where lowest cost is important
    - Max throughput: 250 MiB/s - max IOPS 250


## IOPS SSD (io1) volumes size to throughput ratio

- The maximum ration of provisioned IOPS to requested volume size (in GiB) is 50:1. For example, on a 100 GiB volume, you can provision up to 5,000 IOPS.
- Any volume over 1280GiB or greater allows provisioning up to 64,000 IOPS maximum (50x1280 = 64000)




Question: Cluster composed of EC2 Instances with Provisioned IOPS(io1) EBS Volumes. The size of each volume is 10 GiB.  You must maintain high IOPS while keeping the latency down by setting the optimal queue length of the volume. What is the optimal queue length for the volume?

Answer: 10GiB x 50 = 500 IOPS

## References

https://tutorialsdojo.com/amazon-ebs/

https://youtu.be/LW7x8wyLFvw

http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-io-characteristics.html