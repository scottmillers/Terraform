# EC2 Monitoring

By default EC2 instances monitor the following metrics:
- CPU Utilization
- Network utilization
- Disk performance
- Disk I/O

Certain metrics like:
- Memory utilization
- Disk swap utilization
- Disk space utilization
- Page file utilization
- Log collection

Can be monitored by installing the CloudWatch agent on the EC2 instance.

- Cloudwatch sends data to CloudWatch every 5 minutes by default.
- You can also enable detailed monitoring to collect data in 1-minute periods

## References

https://tutorialsdojo.com/amazon-elastic-compute-cloud-amazon-ec2/

https://tutorialsdojo.com/amazon-cloudwatch/