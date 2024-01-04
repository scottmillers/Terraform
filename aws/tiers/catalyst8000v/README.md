![Cisco Logo](docs/images/cisco.png)
# Cisco Catalyst 8000V SD-WAN on AWS

## Problem Statement
-	We use the Cisco Catalyst 8000V SD-WAN to optimize TIERS network traffic
- We optimizes the network traffic to the Winters Data Center from over 200 regional offices
- We terminate the regional offices connection at the Winters Data Center
- We are moving the TIERS production systems from the Winters Data Center to AWS
- We need to move Cisco Catalyst 8000V SD-WAN to AWS
- We need to terminate the regional offices connection in AWS
- We do not know if the Cisco Catalyst 8000V SD-WAN will meet our requirements on AWS
- If the Cisco Catalyst 8000V SD-WAN does not meet our requirements running on AWS:
  - We have no alternative solution
  - The TIERS project scope, schedule, and budget will be impacted

## Solution

We want to do a proof of concept of the Cisco Catalyst SD-WAN software on AWS.  

The proof of concept will answer the following questions: 
  - Will the Cisco Catalyst 8000V SD-WAN work on AWS?
  - Will we get the same network optimization to AWS in us-east-2 as we get now to Winters?
  - What is the required AWS compute, storage, and network configuration to run the Cisco Catalyst 8000V on AWS?
  - What is the optimal AWS compute, storage, and network to get the same network optimization(for example, 85% ) we get now?
  - How should we design the Cisco Catalyst 8000 SD-WAN architecture on AWS meet the TIERS availability and Disaster recovery requirements?
  - How does the Cisco Catalyst 8000V SD-WAN on AWS integrate with our existing network monitoring and management tools?
  - Does our AWS design for the proof of concept follow the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc&wa-guidance-whitepapers.sort-by=item.additionalFields.sortDate&wa-guidance-whitepapers.sort-order=desc)?



The proof of concept effort will deliver the following artifacts:
  - Design document that describes the architecture and configuration required to use Cisco Catalyst 8000V SD-WAN on AWS
  - Report with data that compares the AWS performance to the current network performance and bandwidth optimizations
  - Infrastructure as Code, or [Terraform](https://www.terraform.io/) scripts, to build and destroy the AWS infrastructure
  - Configuration as Code, in [Ansible](https://www.ansible.com/), to configure anything on the EC2 instances including but not limited to the Cisco Catalyst Edge software

## Schedule, costs and licensing

- We expect the proof of concept to take 3 months.
- The infrastructure estimated costs we estimated at the largest EC2 instance sizes for the proof of concept.  We will use a small instance.  The costs will be less than estimated.
- We will Bring our Own License (BYOL) for the Cisco Catalyst 8000V SD-WAN software
    

## Status Update (01/03/2024)
- Problem: I am unable to create a new EC2 instance from the Cisco 8000V Marketplace AMI in the Ohio (us-east-2) region. Here are the [Steps to reproduce](CiscoAmiAccessProblem.md)

## Status Update (12/20/2023)

- PCR has been approved
- We have a new dedicated sandbox account funded by the project
- Success. I was able to create a new EC2 instance from the Cisco 8000V Marketplace AMI in the Virginia(us-east-1) region.  Here are the [Steps to reproduce](./02-Marketplace-Launch/docs/CiscoAmiAccess.md).

## Status Update (11/14/2023)

- We have been informed by PCM/Rackspace:
    - They require a PCR and a detailed cost breakdown to build the environment 
- A new PCR will have to be started.  The time frame is at 1-2 months for approval. We will not be able to start until the PCR is approved.  Therefore the project start is moved to 2023-01-01.
- The Project will be impacted: 
  - Costs will increase we will have to pay for AWS Infrastructure when not used.  
  - Time will increase since we will have to wait for PCM/Rackspace to build the environment.


## Pre-requisites

- AWS Access **(Done!)**:smiley:
  - We will use a AWS Sandbox account acquired through the Service Now Portal
- Cisco Catalyst 8000V SD-WAN software license **(Done!)**:smiley:
  - For both the proof of concept and production the network team will use the Bring Your Own License (BYOL) option to deploy the Cisco Catalyst 8000V software on AWS. See [our documentation](CiscoCatalystLicensing.md) on which Cisco license option we will use once we get access to the AWS MarketPlace AMI.  
- AWS Marketplace Access **(AWS Policy change required)**:disappointed:
  - We need to use the [Cisco Catalyst 8000V image for SD-WAN and Routing image](https://aws.amazon.com/marketplace/pp/prodview-rohvq2cjd4ccg) from the AWS Marketplace. [Texas procurement rules](https://comptroller.texas.gov/purchasing/publications/procurement-contract.php) forbids AWS Marketplace access since purchasing from it is considered a single source procurement which is forbidden under law. 
  - 2023-11-01: We tried multiple workarounds to get or build AMI image without AWS Marketplace access.  None of them worked.  See [our documentation](./MarketplaceAccess.md) for details. 
  - We requested an exception to DIR for AWS Marketplace access
  - 2023-11-06: DIR approved the exception to allow AWS Marketplace Access.  We need PCM/Rackspace to modify their AWS policies to allow our AWS sandbox account to use the AWS Marketplace.
  - 2023-11-14: Rackspace said that they will not allow the policy change for AWS Marketplace access. ls
   They want to create the EC2 instances from the AWS Marketplace AMI.  They also said we need to create a PCR to get the environments built.


## High-Level Design

The following diagram shows a draft of the high-level design for the production system.

![AWS High-Level architecture](images/design-high.svg)

 



