# SSH Keys to Login to EC2 Instances

This folder contains files used to create public and private keys for SSH access to EC2 instances.

Steps to use:

1. Copy the files into your Terraform configuration folder.  Include the script directory files too and the .gitignore file.
2. Add the public key_name to your instances. 

``` terraform
# Add the public key_name to your instance
resource "aws_instance" "web_srv_one" {
  key_name = aws_key_pair.ssh-public-key.key_name
```

3. Modify the ssh-login.tf file to include the public ip addresses of the EC2 instances you want to connect.

``` terraform
# Change this to be the IP address of your EC2 
    EC2="${aws_instance.web_srv_one.public_ip}"
```

4. Run the Terraform commands to create the keys and the instances.

5. Run the scripts/ssh-ec2.sh script to connect to the EC2 instances.

