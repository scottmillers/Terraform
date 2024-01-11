
## Status Updates

### 01/03/2024
- Problem: I am unable to create a new EC2 instance from the Cisco 8000V Marketplace AMI in the Ohio (us-east-2) region using the AWS Console. Here are the [Steps to reproduce](docs/CiscoAmiAccessProblem.md)
- Solution: The AWS Console has a bug.  Rackspace opened a support ticket.  We can create the instance through the AWS CLI or Terraform.  We have a workround.  We will continue with the proof of concept.

### 12/20/2023

- PCR has been approved
- We have a new dedicated sandbox account funded by the project
- Success. I was able to create a new EC2 instance from the Cisco 8000V Marketplace AMI in the Virginia(us-east-1) region.  Here are the [Steps to reproduce](./02-Marketplace-Launch/docs/CiscoAmiAccess.md).

### 11/14/2023

- We have been informed by PCM/Rackspace:
    - They require a PCR and a detailed cost breakdown to build the environment 
- A new PCR will have to be started.  The time frame is at 1-2 months for approval. We will not be able to start until the PCR is approved.  Therefore the project start is moved to 2023-01-01.

###  11/06/2023
- DIR approved the exception to allow AWS Marketplace Access.  We need PCM/Rackspace to modify their AWS policies to allow our AWS sandbox account to use the AWS Marketplace.

### 11/01/2023
- We tried multiple workarounds to get or build AMI image without AWS Marketplace access.  None of them worked.  See [our documentation](./docs/MarketplaceAccess.md) for details. 
  - We requested an exception to DIR for AWS Marketplace access



