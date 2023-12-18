# AWS Global Accelerator vs CloudFront

- They both use the AWS Global Network and its Edge Locations around the world
- Both services integrate with AWS Shield for DDoS protection

## AWS CloudFront

- Improves performance for both cacheable content (such as images and videos)
- Dynamic content (such as API acceleration and dynamic site delivery)
- Content is served at the edge locations


## AWS Global Accelerator
- Improves performance for a wide range of applications over TCP or UDP
- Proxying packets at the edge to applications running in one or more AWS Regions
- Good fit for non-HTTP use cases that require static IP addresses
- Good fit for non-HTTP use cases, such as gaming (UDP), IoT (MQTT), or Voice over IP (UDP)
- Good fit for HTTP use cases that require deterministic, fast regional failover
- Good fit for HTTP use cases that require fast regional failover
- Good fit for HTTP use cases that require static IP addresses