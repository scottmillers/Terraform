![Cisco Logo](images/cisco.png)
# How to deploy a EC2 Instance from the Cisco Catalyst 8000V AMI in the AWS Marketplace

## Steps for a Successful Deployment

Goal: Start a EC2 instance from the Cisco 8000V image in Virginia(us-east-1) **(Success!)**:smiley:
- Steps:
    - Step 0: Verify you are in the Virginia (us-east-1) region 
    - Step 1: Go to the EC2 AMI Catalog list 
    - Step 2: Find the Cisco 8000V for SD-WAN & Routing
        ![Alt text](images/ec2-ami-catalog.png)
    - Step 3: Click the Select button next to the Cisco 8000V for SD-WAN & Routing
        ![Alt text](images/ec2-ami-select-8000v.png)
    - Step 4: Click Continue
    - Step 5: Click "Launch Instance with AMI"
        ![Alt text](images/ec2-ami-launch-instance.png)
    - Step 6: Fill in the details for the EC2 Instance
        ![Alt text](images/ec2-ami-instance-details.png)
    - Step 7: Click "Launch Instance"
    - Step 8: Wait for your Instance to launch
        ![Alt text](images/ec2-launched-instance.png)


Goal: Access the AWS Marketplace Directly to get access to the AMI  **(Fail!)**:disappointed:
- Steps:
    - Step 1: Go to the AWS Marketplace
        - Error:  Error retrieving subscriptions
        - Reason: Appears to be a Service Control Policy at the Organizational Level. 
    ![Alt text](images/error-manage-subscription.png)


   




