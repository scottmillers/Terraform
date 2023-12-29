# Lambda Pricing

- Pay per calls:
    - First 1 million requests per month are free
    - $0.20 per 1 million requests thereafter ($0.0000002 per request)
- Pay per duration: (in increment of 1 ms)
    - 400,000 GB-seconds of compute time per month
        - 400,000 GB-seconds of compute time per month if function is 1 GB RAM
        - 3,200,000 GB-seconds of compute time per month if function is 128 MB RAM
        - After that $1.00 per 600,000 GB-seconds of compute time ($0.000001667 for every GB-second)