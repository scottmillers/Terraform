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


## Aurora Endpoints

- Use endpoints to map each connection to the correct instance or group of instances
- For clusters with DB instances of different capacities or configuration, you can connect ot custom endpoints associated with different subnets of DB instances
- Types of Endpoints
    - Cluster Endpoint or Writer Endpoint: connects to the current primary instance for the cluster
    - Reader Endpoint: connects to one of the available read replicas for the cluster
    - Custom Endpoint: connects to a specific DB instance or group of DB instances defined by you

![Alt text](image.png)

## Aurora Events from MySQL DB cluster


- Invoke a Lambda function when an Aurora DB cluster event occurs using lambda_sync or lambda async
- Capture data changes when a row in a table is modified

## References

https://youtu.be/iwS1h7rLNBQ


https://tutorialsdojo.com/amazon-aurora/

Endpoint:
https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.Endpoints.html



