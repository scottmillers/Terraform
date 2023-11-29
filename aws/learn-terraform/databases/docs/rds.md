# Amazon RDS Overview

- Managed PostgreSQL, MySQL, Oracle, SQL Server, MariaDB, and Custom
- Provisioned RDS Instance Size and EBS Volume Type & Size
- Auto-scaling capability for Storage
- Support for Read Replicas and Multi-AZ
- Security through IAM, Security Groups, KMS, SSL, and VPC
- Automated Backups with point in time restore features (up to 35 days)
- Manual DB Snapshot for longer-term recovery
- Managed and scheduled maintenance (with downtime)
- Support for IAM Authentication, integration with AWS Secrets Manager
- RDS Custom for access to an d customize the underlying instance (Oracle and SQL Server only)

## High availability using Multi-AZ


- You can run your DB instance in several AZs, and option called a Multi-AZ deployment.
- Amazon automatically provisions and maintains a secondary standby DB instance in a different AZ.  Your primary DB instance is synchronously replicated across Azs to the secondary instance to provide data redundancy, eliminate I/O freezes, and minimize latency spikes during system backups.  In the event of planned database maintenance, DB instance failure, or an AZ failure, Amazon RDS automatically fails over to the standby so that database operations can resume quickly without administrative intervention.  Multi-AZ deployments for Oracle, PostgreSQL, MySQL, MariaDB, and SQL Server DB instances use Amazon technology, while Amazon Aurora DB instances use Aurora replication.  Multi-AZ deployments are not supported for SQL Server DB instances using SQL Server Mirroring, or for Oracle DB instances using Oracle Data Guard.

![Alt text](images/rds-failover.png)

## RDS Monitoring

- Amazon Cloudwatch
- RDS Events
    - An Amazon RDS event is created when the reboot is completed
    - Be notified when changes occur with a DB instance, DB snapshot, DB parameter group, DB security group, or DB option group
    - Uses the Amazon SNS service to send notifications when an event occurs
- Database log files
- Use enhanced monitoring to collect metrics in real time for the operating system (OS) that your DB instance runs on
- Enhanced monitoring gathers its metrics from an agent on the instance, whereas CloudWatch gathers its metrics from the hypervisor

## Reference
RDS Overview
https://youtu.be/aZmpLl8K1UU

Cheat Sheet
https://tutorialsdojo.com/amazon-relational-database-service-amazon-rds/
