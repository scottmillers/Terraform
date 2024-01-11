![Cisco Logo](images/cisco.png)
# Technical Design - Cisco Catalyst 8000V SD-WAN on AWS 

This is the design for the Cisco Catalyst 8000V SD-WAN on AWS Proof of Concept.  


## High Level Design

![High Level Design](images/design-high.svg)

The diagram above shows the high level design for the production system. 

The HHS-TIERS-NET VPC will have two subnets in two availability zones for the Cisco Edge 8000V SD-WAN.

The Cisco Edge 8000V SD-WAN will be composed of two components of a Cisco 8000V Controller
and Node. 

To HHS-TIERS-PROD VPC will have a subnet with a simple web server to simulate the TIERS workload.  

## Instances

We will use 3 EC2 instances.  They are:
- The Cisco Controller
    - This instance will be created from the Cisco Catalyst 8000V for SD-WAN & Routing BYOL AMI(Ver 17.13.01a ) in the AWS Marketplace
     -The Cisco 8000V AMI in the AWS Marketplace will create a 16 GiB  gp2 EBS volume for the software.  
    - A 2TB gp3 EBS volume to it. 
- The Cisco Node 
    - This instance will be created from the Cisco Catalyst 8000V for SD-WAN & Routing BYOL AMI(Ver 17.13.01a ) in the AWS Marketplace
    -The Cisco 8000V AMI in the AWS Marketplace will create a 16 GiB  gp2 EBS volume for the software.  
    - A 2TB gp3 EBS volume to the Cisco Node.  
- TIERS Web Server
    - This instance is to simulate the TIERS main web server.  It will use the latest Amazon Linux image with a simple web server installed. 


All EC2 instances will start out as a **c5n.large**. The technical specs for this instance type are:
- 2 vCPU
- x86_64 architecture
- 5.3 GiB memory
- Up to 25 Gigabit network performance

I will adjust the instance type as needed based on the performance.

This [Cisco documentation](https://www.cisco.com/c/en/us/td/docs/routers/C8000V/AWS/deploying-c8000v-on-amazon-web-services/deploy-c8000v-on-amazon-web-services.html#task_1084927)  list the supported instance types. 



## Network Bandwidth Requirements

We need a 10 Gbps between the Cisco Controller and Node.  

The c5n.large instance type provides up to 25 Gbps of network performance.  However, this [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-network-bandwidth.html) says "Baseline bandwidth for single-flow traffic is limited to 5 Gbps when instances are not in the same cluster placement group. To reduce latency and increase single-flow bandwidth, try one of the following:
- Use a cluster placement group to achieve up to 10 Gbps bandwidth for instances within the same placement group.
- Set up multiple paths between two endpoints to achieve higher bandwidth with Multipath TCP (MPTCP).
- Configure ENA Express for eligible instances within the same subnet to achieve up to 25 Gbps between those instances.

We might need to create a cluster placement group for the Service Controller and Service Node.  Further research on all these options is required.
 

## Network Interfaces and Security Rules

![Network Interfaces](images/network-ec2-ports.svg)

The diagram above shows the EC2 instances and their network interfaces.  


### CIDR Ranges

The following table shows the CIDR ranges used for AWS networking as well as the rules that will be used in the AWS security rules.

| CIDR Rule Name  | Description | Location |  CIDR Ranges  |  
|---|---|---|---|
| HHS-TIERS-NET |   VPC for Network workload | AWS |  100.101.0.0/24 | 
| HHS-CISCO-8000V |   Subnet for Controller and Node | AWS | 100.101.0.0/25 | 
| HHS-TIERS-PROD|   VPC for Application workloads | AWS | 10.0.0.0/24  | 
| HTTP-SERVERS-A|   Subnet for web Server | AWS | 10.0.0.0/25   | 
| HHS-SDWAN-SSH |   HHS range to allow SSH | HHS| 147.80.59.0/24 147.80.194.0/25 160.42.54.0/24 168.32.73.0/24 168.32.140.0/26   | 
| HHS-SDWAN-SNMP |   HHS range to allow SNMP | HHS | 168.32.73.0/24 147.80.59.0/24   | 
| CISCO-VMANAGE |   Cisco VManage SaaS | AZURE | 52.160.32.70 52.240.57.109 52.240.57.161 52.249.198.50 20.185.181.82 13.83.131.89   | 
 


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
| 2 | VPN0 | Controller Management  |  SDWAN |  Controller  |  Yes/No  |  SSH  |  22  | [HHS-SDWAN-SSH](#cidr-ranges) | Traffic from HHS SDWAN for Operations Team |
| 3 | VPN0 | Network Management Tools   |  SDWAN |  Controller  |  Yes/No  |  SNMP  |  161-162  | [HHS-SDWAN-SNMP](#cidr-ranges)| Traffic from HHS SDWAN for the network management tools | 
| 4 | VPN0 | VManage configuration   |  VManage |  Controller  |  Yes/No  |  SSH  |  22  | [CISCO-VMANAGE](#cidr-ranges)  | Traffic from Cisco VManage for configuration  |
| 5 | VPN0 |  VManage communication  | VManage |   Controller  |  Yes/No  |  TCP  |  830  | [CISCO-VMANAGE](#cidr-ranges)   | Traffic from VManage for System use  |
| 6 | VPN0 | VManage communication   | VManage  |  Controller  |  Yes/No  |  UDP  |  12346-12445  | [CISCO-VMANAGE](#cidr-ranges)    | Traffic from VManage for System use   |
| 7 | VPN0 | IPSec (Allow IKE)  | VManage  |  Controller  |  Yes/No  |  UDP  |  500  | [CISCO-VMANAGE](#cidr-ranges)    | Traffic for IPSec IKE from VManage   |
| 8 | VPN0 | IPSec (NAT-T)  | VManage  |  Controller  |  Yes/No  |  UDP  |  4500  | [CISCO-VMANAGE](#cidr-ranges)    | Traffic for IPSec NAT Traversal from VManage   |
| 9 | VPN0 | IPSec (IP 50)  | VManage  |  Controller  |  Yes/No  |  50  |  ALL  | [CISCO-VMANAGE](#cidr-ranges)    | Traffic for IPSec IP Protocol 50 from VManage   |
| 10 | VPN0 | IPSec (IP 51)  | VManage  |  Controller  |  Yes/No  |  51  |  ALL  | [CISCO-VMANAGE](#cidr-ranges)    | Traffic for IPSec IP Protocol 51 from VManage   |
| 11 | SCI | Allow all inbound    |  Subnet | Controller |  Yes/No  |  All  |  All  | [HHS-CISCO-8000V](#cidr-ranges)     | Allow incoming from subnet | 
| 12 | SCI | Allow all outbound   |  Controller | Subnet |  No/Yes  |  All  |  All  | All | Anywhere within subnet |
| 13 | VPN1 | Allow inbound ping from anywhere |  All |  Controller |  Yes/No  |  ICMP  |  -  | All | Allow ping for testing | 
| 14 | VPN1 | Allow all outbound to HHS-TIERS-PROD VPC    |  Controller | HHS-TIERS-PROD VPC |   No/Yes  |  All  |  All  | [HHS-TIERS-PROD](#cidr-ranges) | Traffic to workload VPC | 


 

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
| 1 | SCI | Allow all inbound   |  Subnet  | Node |  Yes/No  |  All  |  All  | [HHS-CISCO-8000V](#cidr-ranges) | Allow incoming from subnet | 
| 2 | SCI | Allow all outbound   |  Node | Subnet |  No/Yes  |  All  |  All  | All | Anywhere within subnet |




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
| 2 | VPN0 | Web Server Management  |  HHS SDWAN |  Controller  |  Yes/No  |  SSH  |  22  | [HHS-SDWAN-SSH](#cidr-ranges) | Traffic from HHS SDWAN for Operations Team |
| 3 | VPN0 | Web Server HTTP  |  All |  Web Server  |  Yes/No  |  TCP  |  80  | All | HTTP traffic to web server |
| 4 | VPN1 | Allow inbound ping from anywhere |  All |  Node |  Yes/No  |  ICMP  |  -  | All | Allow ping for testing  | 
| 5 | VPN1 | Allow inbound HTTP from Controller | Controller |  Web Server |  Yes/No  |  TCP  |  80  | Controller Static IP | Allow  HTTP from Controller | 
| 6 | VPN1 | Allow all outbound to Network VPC    |  Web Server  |  HHS-TIERS-NET VPC CIDR Range |  No/Yes  |  All  |  All  |  [HHS-TIERS-NET](#cidr-ranges) | Traffic to Network VPC | 




