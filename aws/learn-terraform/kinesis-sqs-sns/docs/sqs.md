# AWS Simple Queue Service (SQS)





## References
https://tutorialsdojo.com/amazon-sqs/

https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-best-practices.html

## Question & Answer

### Question 1
A company launched a website that accepts high-quality photos and turns them into a downloadable video montage. The website offers a free and a premium account that guarantees faster processing. All requests by both free and premium members go through a single SQS queue and then processed by a group of EC2 instances that generate the videos. The company needs to ensure that the premium users who paid for the service have higher priority than the free members.

How should the company re-design its architecture to address this requirement?

- A. Create two SQS queues: one for free members and one for premium members. Have the EC2 instances poll the premium queue first and if empty, poll the free queue.


![Alt text](images/question-sqs.png)