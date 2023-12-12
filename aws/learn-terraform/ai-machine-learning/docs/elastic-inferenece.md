# AWS Elastic Inference (EI)

- Elastic Inference (EI) is a resource you can attach to your Amazon EC2 instances to accelerate your deep learning (DL) inference workloads.
- Allows attaching low-cost GPU-powered inference acceleration to:
    - Amazon EC2 instances
    - SageMaker instances
    - ECS tasks
- Reduces machine learning inference costs by up to 75%.

## Use Cases

- Computer vision
- Natural language processing
- Speech recognition

## Concepts

- Accelerator types:
    - a GPU-powered hardware device provisioned
    - It is not part of the hardware where you instance is hosted
    - Uses AWS PrivateLink endpoint service to attach to the instance over the network
- Only a single endpoint service is required in every AZ to connect EI accelerators to instances in that AZ

## Features
- Supports TensorFlow, Apache MXNet, and ONNX models, PyTorch


## References

https://tutorialsdojo.com/amazon-elastic-inference/

https://aws.amazon.com/machine-learning/elastic-inference/features/

https://docs.aws.amazon.com/elastic-inference/latest/developerguide/basics.html

https://aws.amazon.com/machine-learning/elastic-inference/pricing/


