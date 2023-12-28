# Strongly Consistent Read vs Eventually Consistent Read

- Eventually Consistent Read (default)
    - Consistency across all copies of data is usually reached within a second
    - Repeating a read after a short time should return the updated data
    - If you need to read the data from multiple copies of data in multiple regions, you must use eventually consistent reads
    - Less expensive than strongly consistent reads
    - Use case: applications that need to read data that is less than a second old

- Strongly Consistent Read
    - Returns a result that reflects all writes that received a successful response prior to the read
    - Consistency across all copies of data is usually reached within a second
    - Set "ConsistentRead" parameter to True in API calls (GetItem, BatchGetItem, Query, Scan)
    - Consumes twice the RCU as eventually consistent reads