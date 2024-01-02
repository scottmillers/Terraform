# Cisco 8000V Edge Software on AWS


## Product Naming
Cisco Controllers is now called Cisco Catalyst SD-WAN Controller component.


##  Documentation

- [Getting Started](https://www.cisco.com/c/en/us/td/docs/routers/sdwan/configuration/sdwan-xe-gs-book/cisco-sd-wan-overlay-network-bringup.html#c_Firewall_Ports_for_Viptela_Deployments_8690.xml)


## Steps to Deploy Cisco SD-WAN Controller on AWS

You can boot in two deployment modes:
- [Autonomous Deploying mode](https://www.cisco.com/c/en/us/td/docs/routers/C8000V/AWS/deploying-c8000v-on-amazon-web-services/overview.html)
- [Controller mode](https://www.cisco.com/c/en/us/td/docs/routers/sdwan/configuration/sdwan-xe-gs-book.html)

### Controller mode deployment

We want to use Controller mode.

https://www.cisco.com/c/en/us/td/docs/routers/C8000V/Configuration/c8000v-installation-configuration-guide/day0-bootstrap-configuration.html

Public clouds have one input mechanism through which you can provide the bootstrap information to a VM. However, on the device side, three bootsttrap methods are supported: custom-data, user-data, and SDWAN(via the ciscosdwan_cloud_init.cfg downloaded from vManage)

For example, in AWS, you can provide the bootstrap information in any of the above-mentioned formats to the instance at launch via the EC2 user data text box or the File Upload option. Cisco Catalyst 8000V then determines and processes the configuration information that you provided.

## Steps to Deploy the Cisco Catalyst 8000V on AWS

https://www.cisco.com/c/en/us/td/docs/routers/C8000V/AWS/deploying-c8000v-on-amazon-web-services/deploy-c8000v-on-amazon-web-services.html

1. Select the Cisco Catalyst 8000V - BYOL from the AWS Marketplace. (Done!)
2. Create a VPC, Subnet, Security Group, and Key Pair.
3. Create the EC2 Instance
4. Associate a Public IP Address with the Instance.
5. Install the licenses using the Cisco Smart License Usage Policy

## AWS Network details

This documentation seems old since it doesn't mention using AWS Marketplace to deploy the Cisco Catalyst 8000V - BYOL.
https://www.cisco.com/c/en/us/td/docs/routers/sdwan/configuration/sdwan-xe-gs-book/controller-aws.html

![Alt text](images/network-diagram.png?raw=true "Network Diagram")

## Terraform Examples

This is a lab that uses Terraform to deploy the Cisco Catalyst 8000V.
https://github.com/CiscoDevNet/sdwan-cor-labinfra/tree/main

Cisco has a Terraform provider
https://github.com/CiscoDevNet/terraform-provider-sdwan?tab=readme-ov-file
