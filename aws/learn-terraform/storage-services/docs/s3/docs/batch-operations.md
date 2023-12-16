# S3 Batch Operations


- Perform bulk operations on existing S3 objects with single request, example:
  - Modify object metadata & properties
  - Copy objects between S3 buckets
  - Encrypt and decrypt objects
  - Modify ACL, tags
  - Restore objects from S3 Glacier
  - Invoke Lambda functions to perform custom actions

- A job consists of a list of objects, the action to perform, and optional parameters
- S3 Batch Operations manages retries, tracks progress, sends notifications, generates reports
- You can use S3 Inventory to create a list of objects and use S3 Select to filter the list

- Cool tutorial to use [S3 Batch to transcode videos](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tutorial-s3-batchops-lambda-mediaconvert-video.html)