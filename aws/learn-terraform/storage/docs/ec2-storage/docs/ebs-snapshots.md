# EBS Snapshots

- Make backups (snapshot) of your EBS volume at a point in time
- Not necessary to detach volume to snapshot, but recommended
- Can copy snapshots across AZ or Region

![Alt text](images/ebs-snapshot.png?raw=true "EBS Snapshots")

## Features

- EBS Snapshot Archive
    - Move a snapshot to an "archive tier" that is 75% cheaper than the normal snapshot price
    - Takes within 24 to 72 hours for restoring the achive

- Recycle Bin for EBS Snapshots
    - Setup rules to retain deleted snapshots so you can recover them after an accidental deletion
    - Specify retention (from 1 day to 1 year)

- Fast Snapshot Restore
    - Force full initialization of snapshot to have no latency on the first use ($$$)
  
