# IAM database authentication


## IAM database authentication for MariaDB, MySQL and PostgreSQL

- You can authenticate to your DB instance using AWS Identity and Access Management (IAM) database authentication. 
- You don't need to use a password when you connect.  
- Instead you use an authentication token.
- Authentication tokens are using AWS Signature Version 4 signing process to provide authentication information.
- Benefits
    - Network traffic to and from the database is encrypted using Secure Sockets Layer (SSL)
    - You can use IAM to centrally manage access to your database resources, instead of managing access individually on each DB instance.
    - For applications running on EC2 instances you can use profile credentials specific to your EC2 instance to access your database instead of a password

Reference
 https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html

