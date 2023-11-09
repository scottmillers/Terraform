# S3 Object Encryption


4 types of encryption for S3 objects:
- SSE-S3: encrypts S3 objects using keys handled & managed by AWS
- SSE-KMS: leverage AWS Key Management Service to manage encryption keys
- SSE-C: when you want to manage your own encryption keys
- Client Side Encryption: encrypt data client-side and upload the encrypted data to S3

SSE-S3
- AES-256 encryption type
- Must set header to "x-amz-server-side-encryption":"AES256"
- Encryption/decryption is handled transparently by S3
- Enabled by default

SSE-KMS
- AWS Key Management Service (KMS)
- KMS advantage: user control + audit trail using CloudTrail
- Must set header to "x-amz-server-side-encryption":"aws:kms"

SSE-KMS Limitations
- KMS limits
- When you upload, it calls the GenerateDataKey API to KMS
- When you download, it calls Decrypt API to KMS
- Count towards the KMS quota per second
- You can request a quota increase using the Service Quotas console

SSE-C
- Must use HTTPS
- Encryption key must provided in HTTP headers, for every HTTP request made

Client Side Encryption
- Clients library such as the Amazon S3 Encryption Client
- Clients must encrypt data themselves before sending to S3
- Clients must decrypt data themselves when retrieving from S3
- Customer fully manages the keys and encryption cycle

Amazon S3 - Encryption in transit (SSL/TLS)
- SSL/TLS certificates to encrypt requests
- S3 exposes HTTP and HTTPS endpoints and you can use either to send requests
- Use a S3 bucket policy to enforce encryption in transit(HTTPS)
- HTTPS is mandatory for SSE-C