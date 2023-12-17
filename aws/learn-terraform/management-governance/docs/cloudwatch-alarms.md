# Cloudwatch Alarms

- Alarms are used to trigger notification on any metric
- Various options (sampling, %, max, min, etc.)
- Alarm States:
    - OK
    - INSUFFICIENT_DATA
    - ALARM

- Period:
    - Length of time in seconds to evaluate the metric
    - 1 minute (60 seconds) or 5 minutes (300 seconds)
    - 1 minute is default
    - High resolution custom metrics can have a period of 10 seconds, 30 seconds, or any multiple of 60 seconds


## Cloudwatch Alarm Targets

- EC2:  Stop, Terminate, Reboot, or Recover an EC2 instance
- Auto Scaling Group: Trigger Auto Scaling actions
- SNS: Send a notification to an SNS topic or SQS queue.  From SNS we can launch a Lambda function and do anything we want.

![Alt text](images/cloudwatch-alarm-targets.png)

## Cloudwatch Alarm - Composite Alarms

- Combine multiple alarms together
- Composite alarms are monitoring the states of multiple alarms
- AND and OR rules
- Helpful to reduce "alarm noise" by creating complex composite alarms

![Alt text](images/cloudwatch-alarm-composite.png)

## Cloudwatch Alarm - Good to know

- Alarms can be created based on CloudWatch Logs metrics filters
![Alt text](images/cloudwatch-metric-filter.png)

- To test alarms and notifications, set the alarm state to Alarm using CLI

``` console

aws cloudwatch set-alarm-state --alarm-name "my-alarm" --state-value ALARM --state-reason "testing"

```



