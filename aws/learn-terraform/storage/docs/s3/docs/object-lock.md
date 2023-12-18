# S3 Object Lock (versioning required)

- Adopt a WORM (Write Once Read Many) model
- Block and object version deletion for a specific amount of time
- Retention modes - Compliances and Governance
    - Compliance mode - Retention period **can't** be changed or shortened. Object version can't be overwritten or deleted by any user, including the root user in your AWS account.
    - Governance mode (more flexible) - Retention period can be changed and shortened. Most users can't overwrite or delete an object version or alter its lock settings. However, a user with special permissions can still  change the retention and delete the object.  They can also grant others permission to alter the object version.
- Retention Period: protect the object for a fixed period of time, it can be extended
- Legal Hold: (indefinite period) protect the object until the hold is removed. Different from Retention modes since those have retention periods
    - protect the object indefinitely, independent from retention period
    - can be removed by users with the right permissions 
    - can be freely applied and removed using the s3:PutObjectLegalHold and s3:DeleteObjectLegalHold API calls
