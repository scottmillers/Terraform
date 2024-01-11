![Cisco Logo](docs/images/cisco.png)
# Proof of Concept - Cisco Catalyst 8000V SD-WAN on AWS 

This document is an overview of the purpose and goals for the Cisco Catalyst 8000V SD-WAN on AWS Proof of Concept.

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
- The infrastructure estimated costs we estimated at the largest EC2 instance sizes for the proof of concept.  
- We will Bring our Own License (BYOL) for the Cisco Catalyst 8000V SD-WAN software



## Pre-requisites

- AWS Access **(Done!)**:smiley:
  - We will use a AWS Sandbox account acquired through the Service Now Portal
- Cisco Catalyst 8000V SD-WAN software license **(Done!)**:smiley:
  - For both the proof of concept and production the network team will use the Bring Your Own License (BYOL) option to deploy the Cisco Catalyst 8000V software on AWS. See [our documentation](docs/CiscoCatalystLicensing.md) on which Cisco license option we will use once we get access to the AWS MarketPlace AMI.  
- AWS Marketplace Access **(Done)**:smiley:
  - We need to use the [Cisco Catalyst 8000V image for SD-WAN and Routing image](https://aws.amazon.com/marketplace/pp/prodview-rohvq2cjd4ccg) from the AWS Marketplace. [Texas procurement rules](https://comptroller.texas.gov/purchasing/publications/procurement-contract.php) forbids AWS Marketplace access for a regular Cloud Sandbox account.  This is to prevent single-source purchases which are forbidden under law. 
  - Rackspace created a sandbox account and subscribed to the Cisco Catalyst 8000V image for SD-WAN and Routing image in the AWS Marketplace.  We have access to the image.  We can start the proof of concept.
  


## Design

The detailed technical design can be found here in the [Technical Design document](docs/TechnicalDesign.md) 
 


