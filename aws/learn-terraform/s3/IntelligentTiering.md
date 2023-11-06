# S3 Intelligent Tiering 

The S3 Intelligent-Tiering storage option is designed to optimize costs by automatically moving data to the most cost-effective access tier, without performance impact or operational overhead.

Your S3 bucket has two sections for the S3 Intelligent Tiering storage class.  One is Intelligent-Tiering Archive configuration and the other is Lifecycle rules.  Currently only Intelligent-Tiering Archive configuration is used.  


## Intelligent-Tiering Archive configuration

This enables objects stored in your bucket to tier-down to the Archive Access tier or the Deep Archive Access tier which are optimized for objects that will be rarely accessed for long periods of time.

To view these settings open the S3 bucket and click on the Properties tab.  

The Scope limits what gets archived.  The archive prefix is how you limit what gets archived to particular objects.  For example if you have a prefix of `archive/` then any object that starts with `archive/` will be archived.  If you have a prefix of `archive/2020/` then any object that starts with `archive/2020/` will be archived.  You can have multiple archive prefixes.

Rackspace has setup archiving to only archive objects that start with the prefix `deeparchive`.  Any folder or object with the prefix `deeparchive` will be archived.  


![archive prefix](images/archive-prefix.png)

The Archive rule actions allow you to put the S3 object in Archive Access tier or Deep Archive Access tier.  The Archive Access tier will automatically move objects that haven't been accessed for a minium of 90 days to the Archive Access tier. 

Deep Archive Access tier when enabled, Intelligent-Tiering will automatically move objects that haven't been accessed for a minimum of 180 days to the Deep Archive Access tier.  

The Archive Access tier objects will be retrieved in 3-5 hours and the Deep Archive Access Tier will be retrieved in 12 hours.  The [price is also different](https://aws.amazon.com/s3/pricing/#Intelligent-Tiering_pricing) with Archive Access tier costing more to store, but less to retrieve, than Deep Archive.

![archive rules](images/archive-rules.png)

Rackspace has setup the Archives rules to put objects in the Deep Archive after 180 days if they meet the prefix of `deeparchive`.  This means that any object that starts with `deeparchive` will be archived to the Deep Archive Access tier after 180 days.  

## Lifecycle rules

This allows for more complex Lifecycle rules