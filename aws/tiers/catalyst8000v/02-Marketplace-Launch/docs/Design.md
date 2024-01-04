![Cisco Logo](images/cisco.png)
# Cisco 8000v Design Document

## Overview

## Network Topology and Firewall Rules

The following diagram shows the network topology and firewall rules for the Cisco 8000v.

![Firewall Rules](images/network-firewallrules.svg)



| Rule #   |  Network Element  |  Source |  Destination  | Inbound/Outbound | Protocol  |  Port  |  Allowed CIDR @ Source | Description  |
|---|---|---|---|---|---|---|---|---|
|  1 | Cisco Controller to Node   |  Service Controller |  Service Node  |  Yes/Yes  |  All  |  All  |  All  | Traffic in Private Subnet  |
|  2 | Cisco Controller to VManage   |  Service Controller |  VManage  |  Yes/Yes  |  HTTP  |  443  | 52.160.32.70 52.240.57.109 52.240.57.161 52.249.198.50 20.185.181.82 13.83.131.89   | Traffic over Internet    |
|  3 | Cisco Controller to HHS SDWAN   |  Service Controller |  SDWAN  |  Yes/Yes  |  ?  |  ?  | ?   | Traffic over Internet    |
|  4 | Cisco Service Node to VManage   |  Service Node |  VManage  |  Yes/Yes  |  HTTP  |  443  | 52.160.32.70 52.240.57.109 52.240.57.161 52.249.198.50 20.185.181.82 13.83.131.89    | Traffic over Internet    |
|  5 | Cisco Service Node to HHS SDWAN  |  Service Node |  SDWAN  |  Yes/Yes  |  ?  |  ?  | ?  | Traffic over Internet    |



## EC2 Instances (Cisco Service Controller and Service Node)

- ### Instance Types
- ### Storage Requirements
- ### Network Bandwidth Requirements
- ### Static IP Addresses