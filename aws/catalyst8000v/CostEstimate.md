

We plan to use the following AWS services for the prototype.  
- One VPC
- Two Subnets
- One Internet Gateway
- Two EC2 instances.  Size to be determined but the minimum of The costs are based on the AWS pricing calculator.  



The biggest costs will be the AWS compute and storage costs.  Cisco says the minimum EC2 instance to use the software is t3.medium and we will need two per availability zone.  That is $0.0416 per hour per instance.  The storage costs will be for the Cisco Catalyst 8000V software and the logs.  The Cisco Catalyst 8000V software is 2.5 GB and the logs will be 1 GB per day.  The storage costs will be $0.10 per GB per month.  The costs are based on the AWS pricing calculator.

The following table shows the estimated costs for the prototype.  The costs are based on the AWS pricing calculator.  The costs are for the AWS resources only.  The costs do not include the Cisco Catalyst 8000V software license.  The Cisco Catalyst 8000V software license is a one-time cost of $1,000 per instance.  The Cisco Catalyst 8000V software license is not included in the costs below.

We plan to use automation to build and destroy all AWS resources used by the prototype.  When we are not actively using the AWS resources they will be destroyed.



