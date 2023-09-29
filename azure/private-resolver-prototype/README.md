# Azure Private Resolver Prototype

<table style="width: 100%; border-style: none;"><tr>
<td style="width: 140px; text-align: center;"><a href="https://learn.microsoft.com/en-us/azure/dns/dns-private-resolver-overview"><img width="130px" src="./docs/images/dns-private-resolver-logo.png" alt="Azure Private Resolver logo"/></a></td>
<td>
<strong>Prototype for DNS name resolution using the Azure Private Resolver</strong><br />
<i>Terraform scripts to build the Azure environment</i><br />
</td>
</tr></table>

The Azure Private Resolver is a feature in Azure DNS that allows you to resolve DNS names in a virtual network without the need to configure custom DNS servers. 

Use the Azure Private Resolver to solve the following problems:
- Resolve DNS names to on-premise resources from a virtual machine in an Azure virtual network 
- Resolve DNS names to a Azure resources from a virtual machine in a on-premise network
- Remove the need to maintain, deploy, and setup host files in Azure and on-premise to map IP addresses to DNS names

## Architecture

The Terraform scripts will setup 3 Azure virtual networks
- **On-premise network** - An Azure virtual network that simulates an on-premise network. The real network will be connected to the Azure virtual networks using ExpressRoute. This virtual network has the following resources:
  - **DNS Server** - An Azure virtual machine with Windows Server 2019 that has a DNS server. The DNS server will resolve DNS names for on-premise resources and forward DNS queries for Azure resources to the Azure Private Resolver Inbound subnet.
  - **VM** - An Azure virtual machine for testing DNS name resolution.

- **Hub** - An Azure virtual network that represents the Azure Hub in the Hub and Spoke architecture. This virtual network has the following resources:
    - **Private Resolver** - An Azure Private Resolver that is used to resolve DNS queries across Azure and on-premise
    - **Private Resolver Inbound subnet** - An Azure subnet that is used to forward DNS queries from the on-premise DNS server to the Azure Private Resolver.
    - **Private Resolver Outbound subnet** - An Azure subnet that is used to forward DNS queries from the Azure Private Resolver to the on-premise DNS server.
    - **Private Resolver endpoint rule-set** - An Azure Private Resolver endpoint rule-set is attached to forward DNS queries for on-premise resources to the Azure Private Resolver.
    - **Private DNS Zone** - An Azure Private DNS Zone is attached to the Hub VNet to resolve DNS queries for Azure resources.
    - **VM** - An Azure virtual machine for testing DNS name resolution.

- **Spoke** - An Azure virtual network that represents an Azure spoke in a Hub and Spoke architecture. 
    - **Azure Private Resolver endpoint rule-set** - An Azure Private Resolver endpoint rule-set is attached to forward DNS queries for on-premise resources to the Azure Private Resolver.
    - **Azure Private DNS Zone** - An Azure Private DNS Zone is attached to the VNet to resolve DNS queries for Azure resources.
    - **VM** - An Azure virtual machine for testing DNS name resolution.


![Alt text](docs/images/private-resolver-demo.svg)

## Installation

## Usage

## Features

