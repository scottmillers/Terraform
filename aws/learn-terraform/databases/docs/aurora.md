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

## Aurora Failures

- If you have Replica in the same AZ when failing over, Amazon Aurora flips the canonical name (CNAME) from your DB Instance to point at the healthy replica.
- If you are running Aurora serverless and the DB instance or AZ become unavailable, Aurora will automatically recreated the DB instance in a different AZ
- If you don't have a replica and are not running serverless, aurora will attempt to create a new DB Instance in the same AZ as the original instance


## Practice Test 5, Question 53

A top investment bank is in the process of building a new Forex trading platform. To ensure high availability and scalability, you designed the trading platform to use an Elastic Load Balancer in front of an Auto Scaling group of On-Demand EC2 instances across multiple Availability Zones. For its database tier, you chose to use a single Amazon Aurora instance to take advantage of its distributed, fault-tolerant, and self-healing storage system.

In the event of system failure on the primary database instance, what happens to Amazon Aurora during the failover?

Answer: Amazon Aurora will attempt to create a new DB Instance in the same Availability Zone as the original instance and is done on a best-effort basis


## References

https://youtu.be/iwS1h7rLNBQ


https://tutorialsdojo.com/amazon-aurora/

Endpoint:
https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.Endpoints.html



