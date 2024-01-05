![Cisco Logo](images/cisco.png)
# Technical Design - Cisco Catalyst 8000V SD-WAN on AWS 

This document describes the design for the Cisco Catalyst 8000V SD-WAN on AWS Proof of Concept.  

## Cisco Service Controller and Service Node

### Instance Types

All EC2 instances will start out as **c5n.large**. The technical specs for this instance type are:
- 2 vCPU
- x86_64 architecture
- 5.3 GiB memory
- Up to 25 Gigabit network performance

Unlike the c5 or c5d, which can use up to eight queues for packet processing, the C5n Elastic Network Interface (ENI) can make use of up to 32 queues, giving C5n instances a high amount of network bandwidth — up to 100 Gbps on the c5.18xlarge.

We will adjust the instance type as needed to meet the performance requirements of the Cisco Catalyst 8000v Service Controller and Service Node.

This [Cisco documentation](https://www.cisco.com/c/en/us/td/docs/routers/C8000V/AWS/deploying-c8000v-on-amazon-web-services/deploy-c8000v-on-amazon-web-services.html#task_1084927)  list the supported instance types. 

### Storage Requirements

When you create an EC2 instance from the Cisco AMI the root volume uses a 16 GiB unencrypted gp2 volume.  This cannot be changed.  For the Service Controller and Node I will add a 2TB gp3 EBS volumes for the software.

### Network Bandwidth Requirements

We need 10 Gbps of bandwidth for the Service Controller and Service Node.  The c5n.large instance type provides up to 25 Gbps of network performance.  However, this [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-network-bandwidth.html) says "Baseline bandwidth for single-flow traffic is limited to 5 Gbps when instances are not in the same cluster placement group. To reduce latency and increase single-flow bandwidth, try one of the following:
- Use a cluster placement group to achieve up to 10 Gbps bandwidth for instances within the same placement group.
- Set up multiple paths between two endpoints to achieve higher bandwidth with Multipath TCP (MPTCP).
- Configure ENA Express for eligible instances within the same subnet to achieve up to 25 Gbps between those instances.

This means we need to might need to create a cluster placement group for the Service Controller and Service Node.  Further research required.

### Static IP Addresses

The Cisco Service Controller and Service Node will each have an Internet facing static ip address using an Elastic IP address. These Elastic IP addresses will remain even if the EC2 instance is stopped or terminated.

The Cisco Service Controller and Service Node will also use static internal IP addresses for their private interfaces.  


### Network Security Rules

The following diagram shows the security rules for the Cisco 8000v Service Controller, Service Node and the TIERS web server.

![Firewall Rules](images/network-ec2-ports.svg)



Both the Cisco 8000v Service Controller and Node have the same security rules to access the Internet through rule ID-VPN0-WAN.  The table below shows the VPN0-WAN rules to allow the Cisco 8000v Service Controller and Service Node to access the Internet. 

| Rule #   | Rule ID   |  Network Element  |  Source |  Destination  | Inbound/Outbound | Protocol  |  Port  |  Allowed CIDR | Description  |
|---|---|---|---|---|---|---|---|---|---|
| 1 | VPN0-WAN | Cisco Controller to VManage   |  Service Controller |  VManage  |  Yes/Yes  |  SSH  |  22  | 52.160.32.70 52.240.57.109 52.240.57.161 52.249.198.50 20.185.181.82 13.83.131.89   | Traffic to from VManage for Operational Use  |
| 2 | VPN0-WAN | Cisco Controller to VManage   |  Service Controller |  VManage  |  Yes/Yes  |  TCP  |  830  | 52.160.32.70 52.240.57.109 52.240.57.161 52.249.198.50 20.185.181.82 13.83.131.89   | Traffic to from VManage for System use  |
| 3 | VPN0-WAN | Cisco Controller to VManage   |  Service Controller |  VManage  |  Yes/Yes  |  UDP  |  12346-12445  | 52.160.32.70 52.240.57.109 52.240.57.161 52.249.198.50 20.185.181.82 13.83.131.89   | Traffic to from VManage for System use   |
| 4 | VPN0-WAN | Cisco Controller to HHS SDWAN   |  Service Controller |  HHS SDWAN  |  Yes/Yes  |  SSH  |  22  | 147.80.59.0/24 147.80.194.0/25 160.42.54.0/24 168.32.73.0/24 168.32.140.0/26 | Traffic to from HHS SDWAN for Operational use |
| 5 | VPN0-WAN | Cisco Controller to HHS SDWAN   |  Service Controller |  HHS SDWAN  |  Yes/Yes  |  SNMP  |  161-162  | 168.32.73.0/24 147.80.59.0/24 | Traffic to from HHS SDWAN for Network management tools | 
| 6 | VPN0-WAN | Cisco Controller IPsec Tunnel   |  Service Controller |  All  |  Yes/Yes  |  UDP  |  12346-12445  | All | Traffic for IPSec | 



The Cisco 8000v Service Controller needs the Network Rules in the table below in addition to the Internet access rules(VPN0-WAN).

| Rule #  | Rule ID   |  Network Element  |  Source |  Destination  | Inbound/Outbound | Protocol  |  Port  |  Allowed CIDR | Description  |
|---|---|---|---|---|---|---|---|---|---|
| 1 | SCI  | Cisco Controller to Cisco Node   |  Service Controller |  Service Node  |  Yes/Yes  |  All  |  All  |  All  | Traffic in Private Subnet  |  
| 2 | VPN1-HHS  | Cisco Controller to Web Server   |  Service Controller |  Web Server |  No/Yes  |  HTTP  |  443  |  All  | Traffic will originate from Controller and Route to Web Server  |  
| 3 | VPN30-IEE  | Cisco Controller to Web Server   |  Service Controller |  Web Server |  No/Yes  |  HTTP  |  443  |  All  | Traffic will originate from Controller and Route to Web Server  |

The Cisco 8000v Service Node needs the Network Rules in the table below in addition to the Internet access rules(VPN0-WAN).
| Rule # | Rule ID   |  Network Element  |  Source |  Destination  | Inbound/Outbound | Protocol  |  Port  |  Allowed CIDR | Description  |
|---|---|---|---|---|---|---|---|---|---|
| 1 | SCI  | Cisco Controller to Cisco Node   |  Service Node |  Service Controller  |  Yes/Yes  |  All  |  All  |  All  | Traffic in Private Subnet  |  


