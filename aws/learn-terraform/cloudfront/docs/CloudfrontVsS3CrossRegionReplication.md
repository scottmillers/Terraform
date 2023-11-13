# CloudFront vs S3 Cross Region Replication

- CloudFront
    - Global Edge Network
    - Files are cached for a TTL (maybe 24 hours)
    - Great for static content that must be available everywhere

- S3 Cross Region Replication
    - Must be setup for each region you want replication to
    - Files are updated in near real-time
    - Read-only
    - Great for dynamic content that needs to dynamic content that needs to be available at low-latency in few regions