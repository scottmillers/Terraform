# Glacier



## Data Model

- Vault
  - Container for storing archives
  - Each vault resource has a unique address with form:
    `https://region-specific endpoint/account-id/vaults/vault-name`
  - Vault operations are region specific
- Archive
  - Can be data such as a photo, video, or document
  - Each archive has a unique address with form:
    `https://region-specific endpoint/account-id/vaults/vault-name/archives/archive-id`

- Job
  - You can perform a select query on an archive, retrieve an archive, or get an inventory of a vault. 
  - Glacier Select runs the query in place and writes the output result to Amazon S3.

- Notification Configuration
  - Because jobs take time to complete, Glacier supports a notification mechanism to notify you when a job is complete.


## Data Access Tiers

Glacier provides three data access tiers:

- Expedited
  - For urgent requests
  - For all but the largest archive (250 MB+) data access in 1-5 minutes
  - Higher cost
  - Provisioned capacity
    - Purchase if your workload requires highly reliable and predictable access to a subset of your data in minutes
    - Ensures that your retrieval capacity for expedited retrievals is available when you need it.
    - Each unit of provisioned capacity provides the throughput of 3 expedited retrievals per minute, or 180 retrievals per hour.

- Standard 

- Bulk 
  - Data access in 5-12 hours
  - Lower cost

## References

https://tutorialsdojo.com/amazon-glacier/

https://docs.aws.amazon.com/amazonglacier/latest/dev/downloading-an-archive-two-steps.html

https://docs.aws.amazon.com/amazonglacier/latest/dev/glacier-select.html

