# AWS Control Tower

- Provides a single location to easily set up your new well-architected multi-account AWS environment
- Used to govern your AWS workloads with rules for security, operations, and compliance
- You can automate the setup of your AWS environment with best-practices blueprints for multi-account structure, identity, access management, and account provisioning workflow 


## Creating Member Accounts

Control Tower provides three methods for creating member accounts:

- Through the Account Factory console that is part of AWS Service Catalog
- Through the Enroll account feature within AWS Control Tower
- From your AWS Control Tower landing zone's management account, using Lambda code and appropriate IAM roles

## References

https://docs.aws.amazon.com/controltower/latest/userguide/account-factory.html

https://aws.amazon.com/blogs/mt/how-to-automate-the-creation-of-multiple-accounts-in-aws-control-tower/

https://aws.amazon.com/blogs/aws/aws-control-tower-set-up-govern-a-multi-account-aws-environment/