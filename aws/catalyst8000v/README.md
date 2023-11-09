![Cisco Logo](docs/images/cisco.png)
# Cisco Catalyst 8000V SD-WAN on AWS

## Problem Statement
-	We use the Cisco Catalyst 8000V SD-WAN software to optimize TIERS network traffic
- We optimizes the network traffic to the Winters Data Center from over 200 regional offices
- We terminate the regional offices connection at the Winters Data Center
- We are moving the TIERS production systems from the Winters Data Center to AWS
- We need to move Cisco Catalyst 8000V SD-WAN software to AWS
- We need to terminate the regional offices connection in AWS
- We do not know if the Cisco Catalyst 8000V SD-WAN software will meet our requirements on AWS
- If the Cisco Catalyst 8000V SD-WAN software does not meet our requirements running on AWS:
  - We have no alternative solution
  - The TIERS project scope, schedule, and budget will be impacted

## Solution

We want to prototype the Cisco Catalyst SD-WAN software on AWS.  

The prototype will answer the following questions: 

  - Will the Cisco Catalyst 8000V SD-WAN software work on AWS?
  - What is the required AWS compute, storage, and network configuration to run the Cisco Catalyst 8000V software on AWS?
  - What is the optimal AWS compute, storage, and network to get the same network optimization(for example, 85% ) we get now?
  - Will we get the same network optimization to AWS in us-east-2 as we get now to Winters?
  - How should we ensure the Cisco Catalyst 8000V SD-WAN software on AWS is highly available and meets our DR requirements?
  - How does the Cisco Catalyst 8000V SD-WAN software on AWS integrate with our existing network monitoring and management tools?
  - Does our AWS design for the prototype follow the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc&wa-guidance-whitepapers.sort-by=item.additionalFields.sortDate&wa-guidance-whitepapers.sort-order=desc)?



The prototype effort will deliver the following artifacts:
  - Design document that describes the architecture and configuration settings required for the Cisco Catalyst 8000V SD-WAN software
  - Report with data that compares the prototype performance to the current network performance and bandwidth optimizations
  - Infrastructure as Code, or [Terraform](https://www.terraform.io/) scripts, to build and destroy the AWS infrastructure
  - Configuration as Code, in [Ansible](https://www.ansible.com/), to configure anything on the EC2 instances including but not limited to the Cisco Catalyst Edge software
 


## Pre-requisites

- AWS Access **(Done!)**:smiley:
  - We will use a AWS Sandbox account acquired through the Service Now Portal
- Cisco Catalyst 8000V SD-WAN software license **(Done!)**:smiley:
  - For both the prototype and production the HHSC networking team will use the Bring Your Own License (BYOL) option to deploy the Cisco Catalyst 8000V software on AWS. See [our documentation](CiscoCatalystLicensing.md) on which Cisco license option we will use once we get access to the AWS MarketPlace AMI.  
- AWS Marketplace Access **(AWS Policy change required)**:disappointed:
  - We need to use the [Cisco Catalyst 8000V image for SD-WAN and Routing image](https://aws.amazon.com/marketplace/pp/prodview-rohvq2cjd4ccg) from the AWS Marketplace. 
  - We tried multiple workarounds to get or build AMI image without AWS Marketplace access.  None of them worked.  See [our documentation](./MarketplaceAccess.md) for details. 
  - We requested an exception to DIR for AWS Marketplace access
  - DIR approved the exception to allow AWS Marketplace Access on 2023-11-06.
  - We need PCM/Rackspace to modify their AWS policies to allow our AWS sandbox account to use the AWS Marketplace.


## High-Level Design

The following diagram shows a draft of the high-level design for the production system.

![AWS High-Level architecture](docs/images/design-high.svg)

 



