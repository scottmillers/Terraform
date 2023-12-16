# CloudFormation

- Declarative way of outlining your AWS Infrastructure, for any resources (most of them are supported)

## Benefits

- Infrastructure as code
    - No resources are manually created, which is excellent for control
    - Changes to the infrastructure are reviewed through code

- Cost
    - Each resources within the stack is stagged with an identifier so you can easily see how much a stack costs you
    - You can estimate the costs of your resources using the CloudFormation template
    - Savings strategy: In dev, you could automation deletion of templates at 5PM and recreate them at 8AM safely

- Productivity
    - Ability to destroy and re-create an infrastructure on the cloud on the fly
    - Automated generation of Diagram for your templates!
    - Declarative programming (no need to figure out ordering and orchestration)

- Don't re-invent the wheel
    - Leverage existing templates on the web
    - Leverage the documentation



## Features

- You can use Rollback Triggers to specify the CloudWatch alarm that CloudFormation should monitor during the stack creation and update process. If any of the alarms you specify goes to ALARM state during the stack operation, CloudFormation rolls back the entire stack operation to the last known stable state.

- Change Sets: Allows preview how the proposed changes to a stack might impact your running resources

- AWS StackSets- lets you provision a common set of AWS resources across multiple AWS accounts and AWS Regions by using a single AWS CloudFormation template. All administrator and target accounts must be in the same organization.

- Cloudformation registry helps you discover, provision, and manage resource types.  


## References

https://tutorialsdojo.com/aws-cloudformation/?src=udemy

https://www.youtube.com/watch?v=9Xpuprxg7aY


