# VPC - Subnets (IPv4)

- AWS Reserves 5 IP addresses (first 4 and last 1) within each subnet
- These 5 IP addresses are not available for use and can't be assigned to an EC2 instance
- Example: if CIDR block 10.0.0.0/24, then reserved IP addresses are:
    - 10.0.0.0 - Network address
    - 10.0.0.1 - reserved by AWS for the VPC router
    - 10.0.0.2 - reserved by AWS for mapping to Amazon-provided DNS
    - 10.0.0.3 - reserved by AWS for future use
    - 10.0.0.255 - Network broadcast address. AWS does not support broadcast in a VPC, therefore the address is reserved

- Exam tip: if you see a question asking how many EC2 instances can be launched in a subnet, subtract 5 from the CIDR block size.  
- Example, you need 29 IP addresses for EC2 instances.  If you choose a CIDR of /27 you get 32 IP addresses, but 5 are reserved by AWS, so you can only launch 27 EC2 instances in that subnet.  This won't work. 


## References
https://www.ipaddressguide.com/cidr
    - 