# Global Accelerator

- A service that uses the AWS Global Network to improve the availability and performance of your applications to your local and global users. 
- It provides static IP addresses that act as a fixed entry point to your application endpoints in a single or multiple AWS Regions, such as your Application Load Balancers, Network Load Balancers or Amazon EC2 instances.
- AWS Global Accelerator continually monitors the health of your application endpoints and will detect an unhealthy endpoint and redirect traffic to healthy endpoints in less than 1 minute.


## Security

-  AWS Global Accelerator lets you associate regional resources, such as load balancers and EC2 instances, to two static IP addresses. 
- You only whitelist these addresses once in your client applications, firewalls, and DNS records.
- DDoS protection thanks to AWS Shield


## EndPoint Groups - Reduce the Number of IP Addresses

- If you have multiple resources in multiple regions, you can use AWS Global Accelerator to reduce the number of IP addresses. 
- By creating an endpoint group, you can add all of your EC2 instances from a single region in that group.
- You can add additional endpoint groups for instances in other regions. 
- After it, you can then associate the appropriate ALB endpoints to each of your endpoint groups. 
- The created accelerator would have two static IP addresses that you can use to create a security rule in your firewall device. Instead of regularly adding the Amazon EC2 IP addresses in your firewall, you can use the static IP addresses of AWS Global Accelerator to automate the process and eliminate this repetitive task.

https://docs.aws.amazon.com/global-accelerator/latest/dg/about-endpoint-groups.html

https://aws.amazon.com/global-accelerator/faqs/

https://docs.aws.amazon.com/global-accelerator/latest/dg/introduction-how-it-works.html



## Global users for our application

- You have deployed an application and have global users who want to access it directly
- They go over the public internet, which can add a lot of latency due to many hops
- We wish to go as far as possible in the network before going over the public internet

- Leverages the AWS internal network to route to your application
- 2 Anycast IP addresses are created for your application
- The Anycast IP send traffic directly to the nearest edge location

- Works with Elastic IP, EC2 instances, ALB, NLB, public and private
- Consistent performance and availability
    - Intelligent routing to lowest latency and fast regional failover
    - No issue with client cache (because the IP does not change)
- Health Checks
  - Global Accelerator performs health checks on your application endpoints every 30 seconds
  - Helps make your application global (failover less than 1 minute)
  - Great for disaster recovery (thanks to health checks)




- Global Accelerator uses Anycast IP addresses which are announced from multiple AWS edge locations
- Unicast IP addresses are announced from a single edge location


# References

https://tutorialsdojo.com/aws-global-accelerator/
