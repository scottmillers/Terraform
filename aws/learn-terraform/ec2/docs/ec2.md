# EC2 


# vCPU limits

- vCPU limits are per region
- vCPU limits are based on the instance type

## Instance States

- Start-run your instance normally
- Stop - normal shutdown.  You can create an AMI from the instance, and change the kernel, RAM disk, instance type, and block device mapping.
- Hibernate - Writes the in-memory state to a file in the root EBS volume and shuts itself down.  When you start the instance, it reads the hibernation file and jumps to the previous running state.  You can't change the kernel, RAM disk, instance type, or block device mapping.
- Terminate - instance performs a normal shutdown and gets deleted.


## Root Device Volumes

- Contains the image used to boot the instance
- You can replace the root volume of a running EC2 instance using the following:
    - Initial launch state
    - Snapshot
    - AMI

## Amazon EC2 - AMI

- Includes the following:
    - Template for the root volume for the instance
    - Launch permissions that control which AWS accounts can use the AMI to launch instances
    - A block device mapping that specifies the volumes to attach to the instance when it's launched

- Backed by Amazon EBS - root device for an instance launched from the AMI is a Amazon EBS volume. 
- Backed by instance store - root device for an instance launched from the AMI is an instance store volume created from a template stored in Amazon S3.

## Networking
- By default, all AWS accounts are limited to five (5) Elastic IP addresses per region
- Every instance in a VPC has a default network interface, called the primary network interface (eth0).  You cannot detach a primary network interface from an instance.
- Elastic Fabric Adapter (EFA) - This is a network device that you can attached to your EC2 instance to accelerate High Performance Computing (HPC) and machine learning applications.  


## Instace Metadata and User Data

- Instance metadata - data about your instance that you can use to configure or manage the running instance.  You can access instance metadata from within the instance using the following URL: http://169.254.169.254/latest/meta-data/

## References
https://tutorialsdojo.com/amazon-elastic-compute-cloud-amazon-ec2/