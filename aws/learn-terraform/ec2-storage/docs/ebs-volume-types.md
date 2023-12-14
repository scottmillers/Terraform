# AWS EC2 Volume Types

3 volume types
- General Purpose 
- Provisioned IOPS
- Magnetic


## Provisioned IOPS SSD (io1) volumes

- Designed for I/O-intensive applications such as large relational or NoSQL databases
- Unlike gp2, which uses a bucket and credit model, io1 allows you to specify a consistent IOPS rate when you create the volume
- Can range in size from 4 GiB to 16 TiB
- Can provision 100 IOPS up to 64,000 IOPS per volume on Nitro system instances and up to 32,000 IOPS per volume on other instances
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