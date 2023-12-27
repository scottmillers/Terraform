# EBS Multi-Attach Volume - io1/io2 family

- Attach the same EBS volume to multiple EC2 instances in the same AZ
- Each instance has full read & write permissions to the high-performance volume
- Use case:
    - Achieve higher application availability in clustered Linux applications
    - Applications must manage concurrent write operations
- Up to 16 EC2 instances can be attached to the same EBS volume
- Must use a file system thats cluster-aware (not XFS, EXT4, etc.)

![Alt text](images/ebs-multi-attach.png)