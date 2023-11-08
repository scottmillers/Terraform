![Cisco Logo](docs/images/cisco.png)
# Using the Cisco Catalyst 8000V Edge software on AWS

## Problem Statement
-	We use the Cisco Catalyst 8000V Edge software to optimize TIERS network traffic
- The Cisco Catalyst 8000V Edge software optimizes network traffic from over 200 regional offices to the Winters Data Center
- The Cisco Catalyst 8000V Edge is currently hosted in the Winters Data Center
- We are moving the TIERS production systems from the Winters Data Center to AWS
- We need to move Cisco Catalyst 8000V Edge software to AWS along with TIERS
- We do not know if the Cisco Catalyst 8000V Edge software will work on AWS
- If the Cisco Catalyst 8000V software does not work as expected on AWS, we have no good solution option to replace it, and we will have to delay the TIERS project and add significant unexpected costs

## Solution

We want to prototype the Cisco Catalyst Edge software on AWS.  

- The prototype will answer the following questions: 

  - Can we get the Cisco Catalyst 8000V software to work on AWS?
  - What is the required AWS compute, storage, and network to run the Cisco Catalyst 8000V software on AWS?
  - What is the optimal AWS compute, storage, and network to get the same end-user network optimization we get now?
  - Will we get the same end-user network optimization to AWS in us-east-2 as we get now in Winters?
  - What is the best way to monitor the Cisco Catalyst 8000V software on AWS? 
  - How does the Cisco Catalyst 8000V software fit into the overall TIERS DR strategy?
  - What changes, if any, do we need to make to our current TIERS DR strategy to accommodate the Cisco Catalyst 8000V software on AWS?
  - Does our AWS design for the prototype follow the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc&wa-guidance-whitepapers.sort-by=item.additionalFields.sortDate&wa-guidance-whitepapers.sort-order=desc)?


- The prototype effort will deliver the following artifacts:
  - Design document that describes the architecture and configuration settings for the Cisco Catalyst Edge software
  - [Terraform](https://www.terraform.io/) to build and destroy the AWS infrastructure
  - Code(TBD but Ansible preferred) to configure the Cisco Catalyst Edge software on AWS
  - Measurement tools and data to compare the prototype to the current network optimization and performance


## Project Status