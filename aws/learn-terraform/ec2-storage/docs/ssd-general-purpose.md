# General Purpose SSD


General Purpose SSD (gp3)

- Delivers a consistent baseline rate of 3000 IOPS and 125 MiB/s regardless of the volume size
- You can provisional additional IOPS (up to 16000) and throughput (up to 1000 MiB/s) beyond the baseline performance at an additional cost
- The maximum rations of provisioned IOPS to requested volume size (in GiB) is 500:1. The maximum rations of provisioned throughput to provisioned IOPS is .25 MiB/sec per 


General Purpose SSD (gp2) 

- Base performance of 3 IOPS per GiB, with the ability to burst to 3000 IOPS for extended periods of time
- Support up to 16000 IOPS and 250 MB/sec of throughput
- The burst duration of a volume is dependent on the size of the volume, the burst IOPS required, and the credit balance when the burst begins. Burst IO duration is computed using the following formula: burst duration = (credit balance) / (burst IOPS) * 300 seconds