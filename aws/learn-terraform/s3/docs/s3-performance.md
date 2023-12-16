# AWS S3 Performance


Amazon S3 now provides increased performance to support:
- 3,500 PUT/COPY/POST/DELETE requests per second to add data and 
- 5,500 GET/HEAD requests per second to retrieve data

This can save significant processing time for no additional charge. Each S3 prefix can support these request rates, making it simple to increase performance significantly.

## Organizaing objects using prefixes

https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-prefixes.html

A prefix is a string of characters at the beginning of the object key name.

For example, if an object (123. txt) is stored as BucketName/Project/WordFiles/123. txt, then the prefix might be BucketName/Project/WordFiles/123.

## Question - PT-5, Question 43

A company deployed a web application that stores static assets in an Amazon Simple Storage Service (S3) bucket. The Solutions Architect expects the S3 bucket to immediately receive over 2000 PUT requests and 3500 GET requests per second at peak hour.

What should the Solutions Architect do to ensure optimal performance?

Do nothing

This S3 request rate performance increase removes any previous guidance to randomize object prefixes to achieve faster performance. That means you can now use logical or sequential naming patterns in S3 object naming without any performance implications. This improvement is now available in all AWS Regions.

## References

https://tutorialsdojo.com/amazon-s3/

https://docs.aws.amazon.com/AmazonS3/latest/dev/request-rate-perf-considerations.html

https://d1.awsstatic.com/whitepapers/AmazonS3BestPractices.pdf

https://docs.aws.amazon.com/AmazonS3/latest/dev/GettingObjectsUsingAPIs.html

