# AWS SageMaker

- A fully managed service that provides every developer and data scientist with the ability to build, train, and deploy machine learning (ML) models quickly
- Provides built-in algorithms and frameworks you can immediately use for model training
- Supports custom algorithms through docker containers
- One click model deployment


## Input modes for transferring training data

- `File` mode: 
    - Copies the training dataset from the input location to a directory in the Docker container
    - Used for incremental training.
- `Pipe` mode: 
    - Directly streams data from Amazon S3 into the training algorithm container.  
    - Used for large datasets.

## Two methods of deploying models

- Amazon SageMaker hosting services
    - Persistent HTTPS endpoint for getting predictions one at a time
    - Suitable for web applications that need sub-second latency

- Amazon SageMaker Batch inference
    - No persistent endpoint
    - Get inferences for an entire dataset