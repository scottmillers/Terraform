![Cisco Logo](images/cisco.png)
# Technical Design - Cisco Catalyst 8000V SD-WAN on AWS 

This document describes the technical design for the Cisco Catalyst 8000V SD-WAN on AWS Proof of Concept.  

The [proof of concept overview document](../README.md) provides information on the goals and outcomes for the proof of concept. 

## High Level Design

![High Level Design](images/design-high.svg)

The diagram above shows the high level design .  The Cisco Edge 8000V SD-WAN is composed of two components:
- Cisco 8000V Controller
- Cisco 8000V Node

## Instance Types

We will use 3 EC2 instances.  They are:
- The Cisco 8000V Controller
    - This instance will be created from the Cisco Catalyst 8000V for SD-WAN & Routing BYOL AMI(Ver 17.13.01a ) in the AWS Marketplace
- The Cisco Node 
    - This instance will be created from the Cisco Catalyst 8000V for SD-WAN & Routing BYOL AMI(Ver 17.13.01a ) in the AWS Marketplace
- TIERS Web Server
    - This instance is to simulate the TIERS main web server.  It will use the latest Amazon Linux image with a simple web server installed. 


All EC2 instances will start out as **c5n.large**. The technical specs for this instance type are:
- 2 vCPU
- x86_64 architecture
- 5.3 GiB memory
- Up to 25 Gigabit network performance

I will adjust the instance type as needed based on the performance.

This [Cisco documentation](https://www.cisco.com/c/en/us/td/docs/routers/C8000V/AWS/deploying-c8000v-on-amazon-web-services/deploy-c8000v-on-amazon-web-services.html#task_1084927)  list the supported instance types. 

## Instance Storage

The Cisco 8000V AMI in the AWS Marketplace will create a 16 GiB  gp2 EBS volume.  This cannot be changed.  

I will attach a 2TB gp3 EBS volume to both the Controller and Node.

## Network Bandwidth Requirements

We need a 10 Gbps between the Service Controller and Service Node.  

The c5n.large instance type provides up to 25 Gbps of network performance.  However, this [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-network-bandwidth.html) says "Baseline bandwidth for single-flow traffic is limited to 5 Gbps when instances are not in the same cluster placement group. To reduce latency and increase single-flow bandwidth, try one of the following:
- Use a cluster placement group to achieve up to 10 Gbps bandwidth for instances within the same placement group.
- Set up multiple paths between two endpoints to achieve higher bandwidth with Multipath TCP (MPTCP).
- Configure ENA Express for eligible instances within the same subnet to achieve up to 25 Gbps between those instances.

We might need to create a cluster placement group for the Service Controller and Service Node.  Further research is required.
 


## Network Interfaces and Security Rules

The following diagram shows the EC2 instances and their network interfaces.  

![Network Interfaces](images/network-ec2-ports.svg)

The following tables show the CIDR ranges for 
- AWS VPCs & Subnets
- HHS SDWAN
- Cisco Catalyst VManage software

| CIDR Rule #  | Location |  Name | CIDR Ranges  |  Description  | 
|---|---|---|---|---|
| 1 | AWS  |  HHS-TIERS-NET  |  100.101.0.0/24 | VPC for TIERS application
| 2 | AWS |  CISCO-8000V-A  |  100.101.0.0/25 |  Subnet for Cisco 8000v controller and node in us-east-1a az
| 3 | AWS  |  HHS-TIERS-PROD  |  10.0.0.0/24 |  VPC for TIERS networking
| 4 | AWS  |  HTTP-SERVERS-A  |  10.0.0.0/25 |  Subnet for TIERS web servers in us-east-1a AZ
| 5 | HHS SDWAN |  SDWAN-SSH  |  147.80.59.0/24 147.80.194.0/25 160.42.54.0/24 168.32.73.0/24 168.32.140.0/26 |  SDWan SSH access 
| 6 | HHS SDWAN |  SDWAN-SNMP  |  168.32.73.0/24 147.80.59.0/24 |  SDWan SNMP access 
| 7 | Cisco VManage |  VMANAGE  |  52.160.32.70 52.240.57.109 52.240.57.161 52.249.198.50 20.185.181.82 13.83.131.89 |  VManage remote access



### Cisco 8000V Controller (EC2 Instance)

The Cisco 8000V Controller has three network interfaces, VPN0, VPN1 and SCI.  

The following table shows the network interfaces and their static IP addresses:

| Interface Name   | IP |  Type  |  Description  | 
|---|---|---|---|
| VPN0 | 3.138.87.240 |  Public  |  Internet. For SDWAN and Cisco VManage access| 
| VPN0 | 100.101.0.4 |  Private  |  Not Used | 
| VPN1 | 100.101.0.5 |  Private  |  To connect to the TIERS Web Server |  
| SCI  | 100.101.0.6 |  Private  |  To connect to the Cisco 8000v Node |  



The following tables shows the security rules for the Cisco 8000V Controller:  

| Security Rule #   | Interface  |  Purpose  |  Source |  Destination  | In/Out | Protocol  |  Port  |  Allowed CIDR | Description  |
|---|---|---|---|---|---|---|---|---|---|
| 0 | VPN0 | Controller Management  |  All | Controller  |  Yes/No  |  SSH  |  22  | All | SSH traffic from anywhere for configuration. This is temporary |
| 1 | VPN0 | Allow all outbound |   Controller |  All  |  No/Yes  |  All  |  All  | All | Traffic from controller to anywhere  |
| 2 | VPN0 | Controller Management  |  SDWAN-SSH |  Controller  |  Yes/No  |  SSH  |  22  | CIDR Rule #5 | Traffic from HHS SDWAN for Operations Team |
| 3 | VPN0 | Network Management Tools   |  SDWAN-SNMP |  Controller  |  Yes/No  |  SNMP  |  161-162  | CIDR Rule #6| Traffic from HHS SDWAN for the network management tools | 
| 4 | VPN0 | VManage controller configuration   |  VManage |  Controller  |  Yes/No  |  SSH  |  22  | CIDR Rule #7  | Traffic from Cisco VManage for configuration  |
| 5 | VPN0 |  VManage communication  | VManage |   Controller  |  Yes/No  |  TCP  |  830  | CIDR Rule #7 | Traffic from VManage for System use  |
| 6 | VPN0 | VManage communication   | VManage  |  Controller  |  Yes/No  |  UDP  |  12346-12445  | CIDR Rule #7  | Traffic from VManage for System use   |
| 7 | VPN0 | IPSec (Allow IKE)  | VManage  |  Controller  |  Yes/No  |  UDP  |  500  | CIDR Rule #7  | Traffic for IPSec IKE from VManage   |
| 8 | VPN0 | IPSec (NAT-T)  | VManage  |  Controller  |  Yes/No  |  UDP  |  4500  | CIDR Rule #7  | Traffic for IPSec NAT Traversal from VManage   |
| 9 | VPN0 | IPSec (IP 50)  | VManage  |  Controller  |  Yes/No  |  50  |  ALL  | CIDR Rule #7  | Traffic for IPSec IP Protocol 50 from VManage   |
| 10 | VPN0 | IPSec (IP 51)  | VManage  |  Controller  |  Yes/No  |  51  |  ALL  | CIDR Rule #7  | Traffic for IPSec IP Protocol 51 from VManage   |
| 11 | SCI | Allow all inbound from Subnet   |  Subnet CIDR | Service Controller |  Yes/No  |  All  |  All  | CIDR Rule #2 | Allow incoming from subnet | 
| 12 | SCI | Allow all outbound   |  Service Controller | All |  No/Yes  |  All  |  All  | All | Traffic from Cisco Controller |
| 13 | VPN1 | Allow all inbound ping from anywhere |  All |  Service Controller |  Yes/No  |  ICMP  |  -  | All | Allow ping for testing | 
| 14 | VPN1 | Allow all outbound to Production VPC    |  Service Controller |  Production VPC CIDR Range |  No/Yes  |  All  |  All  | CIDR Rule #1 | Traffic to anywhere in Production VPC | 







### Cisco 8000V Node


The Cisco 8000V Node has two network interfaces, VPN0 and SCI  

The following table shows the network interfaces and their static IP addresses:

| Interface Name  | IP |  Type  |  Description  | 
|---|---|---|---|
| VPN0 | 18.191.104.100 |  Public  |  Internet. For SDWAN and Cisco VManage access | 
| VPN0 | 100.101.0.10 |  Private  |  Not Used |  
| SCI  | 100.101.0.11|  Private  |  To Cisco 8000v Controller |  


The VPN0 on the Cisco 8000V Node has the same security rules as the Cisco 8000V Controller.  The table below shows the security rules:  

| Rule #   | Interface  |  Purpose  |  Source |  Destination  | In/Out | Protocol  |  Port  |  Allowed CIDR | Description  |
|---|---|---|---|---|---|---|---|---|---|
| 0 | VPN0 | All rules are the same as the Controller  | See Controller | See Controller |  See Controller  |  See Controller  |  See Controller  | See Controller | See Controller | 
| 1 | SCI | Allow all inbound from Subnet   |  Subnet CIDR | Service Controller |  Yes/No  |  All  |  All  | CIDR Rule #2 | Allow incoming from subnet | 
| 2 | SCI | Allow all outbound   |  Service Node | All |  No/Yes  |  All  |  All  | All | Traffic from Cisco Node |




### TIERS Web Server

The TIERS Web Server has two network interfaces, VPN0 and VPN1 

The following table shows the network interfaces and their static IP addresses:

| Interface Name  | IP |  Type  |  Description  | 
|---|---|---|---|
| VPN0 | 3.141.131.41 |  Public  |  Internet. For connections from end-users | 
| VPN0 | 10.0.0.4 |  Private  |  Not Used |  
| VPN1  | 10.0.0.5|  Private  |  To Cisco 8000v Controller |  



| Security Rule #   | Interface  |  Purpose  |  Source |  Destination  | In/Out | Protocol  |  Port  |  Allowed CIDR | Description  |
|---|---|---|---|---|---|---|---|---|---|
| 0 | VPN0 | Web Server Management  |  All | Web Server  |  Yes/No  |  SSH  |  22  | All | SSH traffic from anywhere for configuration. This is temporary |
| 1 | VPN0 | Allow all outbound |   Web Server |  All  |  No/Yes  |  All  |  All  | All | Traffic from web server to anywhere  |
| 2 | VPN0 | Web Server Management  |  HHS SDWAN |  Controller  |  Yes/No  |  SSH  |  22  | CIDR Rule #5 | Traffic from HHS SDWAN for Operations Team |
| 3 | VPN0 | Web Server HTTP  |  All |  Web Server  |  Yes/No  |  TCP  |  80  | All | HTTP traffic to web server |
| 4 | VPN1 | Allow all inbound ping from anywhere |  All |  Node |  Yes/No  |  ICMP  |  -  | All | Allow ping for testing  | 
| 5 | VPN1 | Allow inbound HTTP from Controller | Controller |  Node |  Yes/No  |  TCP  |  80  | Controller Static IP | Allow  HTTP from Controller | 
| 6 | VPN1 | Allow all outbound to Network VPC    |  Node |  Production VPC CIDR Range |  No/Yes  |  All  |  All  | CIDR Rule #2 | Traffic to anywhere in Network VPC | 




