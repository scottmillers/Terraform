# AWS DocumentDB

- Fully managed document database service designed to be fast, scalable, and highly available.
- Data is stored in JSON-like documents.
- Compatible with MongoDb.
- Flexible schema and indexing.
- Commonly used for content management, user profiles, and real-time big data.


## Scaling

- The minimum storage is 10GB. The Amazon DocumentDB storage will automatically scale up to 64 TB in 10 GB increments without affecting performance.
- The Amazon DocumentDB cluster can be scaled by modifying the instance class for each instance in the cluster.
- You can create up to 15 Amazon DocumentDB replicas in the cluster.
- The replication lag is usually less than 100 milliseconds after the primary instance has written an update.

## Security

- You can authenticate a connection to a DocumentDB database through standard MongoDb tools with Salted Challenge Response Authentication Mechanism (SCRAM).
- You can authenticate and authorize the use of DocumentDB management APIs through the use of IAM users, roles, and policies.
- Data in transit is encrypted using Transport Layer Security (TLS).
- Data at rest is encrypted using keys you manage through AWS KMS.
- Amazon DocumentDB supports role based access control ( RBAC ) with built-in roles to enforce the principle of least privileged access.


## References

https://tutorialsdojo.com/amazon-documentdb/



