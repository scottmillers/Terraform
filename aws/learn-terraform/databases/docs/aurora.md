# Aurora

- Compatible API for PostgreSQL and MySQL, separation of storage and compute
- Storage: data is stored in 6 replicas, across 3 AZs - highly available, self-healing, auto-scaling
- Compute: Cluster of DB Instances across multiple AZs, auto-scaling of Read Replicas
- Cluster: Custom endpoint for writer and reader DB instances
- Same security/monitoring/maintenances features as RDS
- Know the back and restore options for Aurora
- Aurora Serverless: auto-scaling, pause and resume, pay per second, good for infrequent, intermittent, or unpredictable workloads
- Aurora Multi-Master: multiple writer nodes, failover between writer nodes in less than 1 second (high-write availability)
- Aurora Global Database: cross-region replication, low latency global reads, disaster recovery. Up to 16 DB read instances in each region, < 1 second storage replication
- Aurora Machine Learning: integrate with SageMaker, use SQL to make predictions
- Aurora Database Cloning: new cluster from existing one, faster than backup/restore, good for testing, dev, etc.
- Use Cases: same as RDS, but with less maintenance/ more flexibility/ more performance/ more features
- 

