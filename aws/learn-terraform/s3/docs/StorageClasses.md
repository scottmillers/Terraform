# S3 Storage Classes

S3 has multiple storage classes that can be used to optimize costs.  The storage classes are:

- S3 Standard
- S3 Standard-Infrequent Access (IA)
- S3 One Zone-Infrequent Access
- S3 Glacier Instant Retrieval
- S3 Glacier Standard Retrieval
- S3 Glacier Deep Archive
- S3 Intelligent-Tiering

Every storage class has the same Durability of (11 9's) across multiple AZ's.  Availability measures how readily available a service and it varies across storage class.  For example, S3 standard has 99.99% availability. 

## S3 Standard

- 99.99% availability
- Used for frequently accessed data
- Low latency and high throughput performance
- Sustains two concurrent facility failures

S3 Standard-IA, and S3 One Zone-IA storage are charged for a minimum storage duration of 30 days, and objects deleted before 30 days incur a pro-rated charge equal to the storage charge for the remaining days. Objects that are deleted, overwritten, or transitioned to a different storage class before 30 days will incur the normal storage usage charge plus a pro-rated charge for the remainder of the 30-day minimum

## S3 Infrequent Access (IA)

Infrequent Access (IA) is for data that is accessed less frequently, but requires rapid access when needed.  S3-Standard IA offers the high durability, high throughput, and low latency of S3 Standard, with a low per GB storage price and GB retrieval charge.

- Same low latency and high throughput performance of standard S3
- 99.9% availability (one nine less than S3 Standard)
- Use case: Disaster recovery, backups

One Zone Infrequent Access (IA) is for data that is accessed less frequently, but requires rapid access when needed.  It is cheaper than S3 Standard-IA, but is only stored in one AZ.  If that AZ is destroyed then the data is lost.  It is used for secondary backup copies of on-premise data, or for data that can be easily re-created.

## S3 Glacier

- Low-cost object storage meant for archiving/backup
- Pricing: price for storage + object retrieval cost

Glacier Instant Retrieval
- Millisecond retrieval
- Minimum storage duration is 90 days. That means you are charged for 90 days even if you delete object before 90 days.

Glacier Flexible Retrieval 
- Expedited: 1-5 minutes, Standard (3-5 hours), Bulk (5-12 hours)- free
- Minimum storage duration is 90 days.

Glacier Deep Archive
- Standard (12 hours), Bulk (48 hours)
- Minimum storage duration is 180 days.

## S3 Intelligent-Tiering
- Small monthly monitoring and auto-tiering fee
- Moves objects automatically between Access Tiers based on usage
- There is no retrieval charge in S3 Intelligent-Tiering

Tiers are 
- Frequent Access tier (automatic): default tier
- Infrequent Access tier (automatic): objects not accessed for 30 days
- Archive Instant Access tier (optional): objects not accessed for 90 days
- Archive Access tier (optional): configurable from 90 days to 700+ days
- Deep Archive Access tier (optional): configurable from 180 days to 700+ days