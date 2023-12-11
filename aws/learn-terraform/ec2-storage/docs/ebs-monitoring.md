# EBS Monitoring

- Cloudwatch monitoring has two types: Basic and Detailed monitoring
- Volume status checks provide information that you need to determine whether your EBS volumes are impaired.  List of status include:
    - Ok - The volume is fine.
    - Warning - The volume is okay, but may have a performance issue.
    - Impaired - The volume is impaired and may be unavailable.
    - Insufficient Data - The instance to which the volume is attached is not reporting data.
    - Volume events are:
        - Awaiting Action: Enable IO
        - IO Enabled
        - IO Auto-Enabled
        - Normal
        - Degraded
        - Severely Degraded
        - Stalled
