# AWS Billing and Cost Management


- Cost Explorer tracks and analyzes your AWS usage
- Use Budgets to manage budgets for your account
- Use Bills to see details about your current charges
- Use Payment History to see your past payment transactions
- With CloudWatch you can create billing alerts that notify you when your usage costs exceed a threshold that you define
- Use **cost allocation tags** to track your AWS costs on a detailed level.  AWS provides two types of cost allocation tags, an AWS generated tags and user-defined tags


## AWS Cost Anomaly Detection

- Uses machine learning to identify unusual spending patterns
- Receive alerts individually in aggregated reports via an email message.  Amazon SNS can be configured to send Slack message notifications
- Billing group is a set of accounts within your consolidated billing family - in the pro forma billing domain only - that shares a common end customer.

## AWS Billing Conductor

- AWS Billing Conductor is a solution that automates the process of setting up a multi-account AWS environment aligned with AWS Organizations best practices.  It also provides a dashboard that gives you visibility into your AWS costs across multiple accounts and services.

- Uses Billing Groups to organize your accounts into logical groups.  You can create a billing group for each of your customers, and then add the accounts that belong to that customer to the billing group.  You can then use the billing group to view the total costs for each customer.


## AWS Cost Explorer

- Visualize, understand, and manage your AWS costs and usage over time
- Create custom reports that analyze cost and usage data
- Analyze your data at a high level: total costs and usage across all accounts, services, and tags
- Or monthly, hourly, or daily resource granularity
- Choose an optimal Savings Plan (to lower prices on your bill)
- Forecast usage up to 12 months based on previous usage


## Cost and Usage Reports (Deprecated)



- Provides information about your use of AWS resources and estimated costs for that usage
- Is a .csv file or a collection of .csv files that are stored in S3
- Can be used to track your Reserved Instance utilization, charges and allocations
- For time granularity, you can choose one of the following:
    - Hourly
    - Daily
    - Monthly
- Reports can be automatically uploaded into AWS RedShift and/or AWS Quicksight for analysis

- Replace by Data Export


## References
https://tutorialsdojo.com/aws-billing-and-cost-management/