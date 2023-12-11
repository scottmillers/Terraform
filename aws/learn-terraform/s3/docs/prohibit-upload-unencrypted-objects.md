# S3 Prohibiting Uploads of Unencrypted Objects


Options for encrypting objects in S3:

1. Server-side encryption:
    - S3 managed keys (SSE-S3)
    - AWS Key Management Service (SSE-KMS)
    - Server-side encryption with customer-provided keys (SSE-C)
2. Client-side encryption
    - Encrypt the data before sending it to S3
    - This provides an additional layer of security by ensuring the object is encrypted before it leaves the client environment

To enforce encryption on S3 buckets, you can use a bucket policy to deny any unencrypted object uploads. 

Here is an bucket policy to enforce encryption:

```
{
     "Version": "2012-10-17",
     "Id": "PutObjPolicy",
     "Statement": [
           {
                "Sid": "DenyIncorrectEncryptionHeader",
                "Effect": "Deny",
                "Principal": "*",
                "Action": "s3:PutObject",
                "Resource": "arn:aws:s3:::<bucket_name>/*",
                "Condition": {
                        "StringNotEquals": {
                               "s3:x-amz-server-side-encryption": "AES256"
                         }
                }
           },
           {
                "Sid": "DenyUnEncryptedObjectUploads",
                "Effect": "Deny",
                "Principal": "*",
                "Action": "s3:PutObject",
                "Resource": "arn:aws:s3:::<bucket_name>/*",
                "Condition": {
                        "Null": {
                               "s3:x-amz-server-side-encryption": true
                        }
               }
           }
     ]
 }


```



## References

https://tutorialsdojo.com/enhancing-s3-bucket-security-by-prohibiting-uploads-of-unencrypted-objects/



