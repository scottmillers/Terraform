# S3 Pre-Signed URLs

- Generate pre-signed URLs using the S3 Console, AWS CLI, or AWS SDKs
- URL Expiration
    - S3 Console - 1 minute to 720 min (12 hours)
    - AWS CLI - 1 second to 7 days.  You configure this in Seconds in the CLI that is 3600 seconds (1 hour) to 604800 seconds (7 days)
- Users given a pre-signed URL inherit the permissions of the person who generated the URL for GET/PUT operations
- Examples:
    - Allow only logged-in users to download a file from your S3 bucket
    - Allow an ever-changing list of users to download a file by generating URLs on the fly