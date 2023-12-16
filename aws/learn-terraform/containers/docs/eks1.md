# Amazon EKS

- A managed service that allows you to run Kubernetes on AWS without installing, operating, or maintaining your own Kubernetes control plane or nodes.

- Integration with various AWS services to provide scalability and security for your applications:
    - Amazon ECR for container images
    - Elastic Load Balancing for load distribution
    - IAM for authentication
    - Amazon VPC for isolation

## Scaling EKS


Amazon EKS supports two autoscaling products:

- Karpeneter

Karpenter is a flexible, high-performance Kubernetes cluster autoscaler that launches appropriately sized compute resources, like Amazon EC2 instances, in response to changing application load. It integrates with AWS to provision compute resources that precisely match workload requirements.

- Cluster Autoscaler

The Kubernetes Cluster Autoscaler automatically adjusts the number of nodes in your cluster when pods fail or are rescheduled onto other nodes. The Cluster Autoscaler uses Auto Scaling groups.

The Kubernetes Horizontal Pod Autoscaler automatically scales the number of Pods in a deployment, replication controller, or replica set based on that resource's CPU utilization. This can help your applications scale out to meet increased demand or scale in when resources are not needed, thus freeing up your nodes for other applications. When you set a target CPU utilization percentage, the Horizontal Pod Autoscaler scales your application in or out to try to meet that target.


## EKS Security

- By default, IAM users and roles do not have permission to create or modify Amazon EKS resources
- In the Amazon EKS control plane, the IAM user or group that creates the cluster is automatically granted permission in the cluster's RBAC configuration.
- To grant additional AWS users or roles access to your cluster, you must edit the aws-auth ConfigMap within Kubernetes
- The aws-auth ConfigMap is automatically applied to your cluster when it is created. You can edit it at any time to add or remove AWS users or roles.
- A service-linked role is predefined by AWS EKS and includes all of the permissions that the service requires to call other AWS services.
- You can enable envelope encryption of Kubernetes secrets using AWS KMS
- The AWS Secrets and Configuration Provider (ASCP) can be used to display secrets from AWS Secrets Manager and parameters from AWS Systems Manager Parameter Store as files.


## Question Test 5: 23
Amazon Elastic Kubernetes Service (Amazon EKS) is used by an e-commerce company to deploy and manage its containerized applications. The website experiences a surge in traffic around the holidays, which significantly adds to the effort. The goal is to ensure that its underlying infrastructure automatically scales in and out in response to demand.

Which of the following would meet the requirements with the LEAST amount of operational overhead? (Select TWO.)

Answer:

- Install the Kubernetes Metrics Server to the Amazon EKS cluster and activate the Horizontal Pod Autoscaler (HPA)
- Setup Karpenter to automatically adjust the number of nodes in the Amazon EKS cluster when pods fail or are rescheduled onto other nodes




## Reference

https://tutorialsdojo.com/amazon-elastic-kubernetes-service-eks/

https://docs.aws.amazon.com/eks/latest/userguide/horizontal-pod-autoscaler.html

https://docs.aws.amazon.com/eks/latest/userguide/autoscaling.html

https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html#aws-auth-configmap

https://docs.aws.amazon.com/eks/latest/userguide/cluster-auth.html
