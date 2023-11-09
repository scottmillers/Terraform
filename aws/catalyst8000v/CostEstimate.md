# Cost Estimate

The purpose of the prototype is to get a more exact cost estimate.  

We plan to use Infrastructure as Code and build the infrastructure.  The AWS infrastructure will only be created when needed and then tear down when it is not needed.  

Therefore costs are difficult to determine.  But we estimate the costs to be less than $500 per month.

The biggest costs will be the AWS compute and storage costs.  Cisco says the minimum EC2 instance to use the software is t3.medium and we will need two per availability zone.  That is 0.0416 per hour per instance or 35 per month.  So that is 70 per month.  We will use two availability zones so that is 140 per month.  We will use the Cisco Catalyst 8000V software for 3 months so that is $420.  

The storage costs will be for the Cisco Catalyst 8000V software and the logs.  The Cisco Catalyst 8000V software is 2.5 GB and the logs will be 1 GB per day.  The storage costs will be $0.10 per GB per month.  The costs are based on the AWS pricing calculator.



