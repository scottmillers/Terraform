# High Performance Computing (HPC)

- The cloud is the perfect place to perform HPC
- You can create a very high number of resources in no time
- You can speed up time to results by adding more resources
- You can pay only for the systems you have used

Use Cases: Perform genomics, computational chemistry, financial risk modeling, weather prediction, machine learning, deep learning, autonomous driving

- Which services help manage HPC

## Data Management & Transfer

- AWS Direct Connect
- Snowball & Snowmobile
- AWS DataSync

## Compute & Network

- EC2 Instances
    - CPU optimized, GPU optimized
    - Spot Instances/Spot Fleets for cost savings + Auto Scaling
- EC2 Placement Groups: Cluster for good network performance

![Alt text](images/hpc-cluster.png)

- EC2 Enhanced Networking (SR-IOV)
    - Higher bandwidth, higher PPS (packet per second), lower latency
    - Option 1: Elastic Network Adapter (ENA) up to 100 Gbps
