# AWS CloudHSM

- A full-managed, cloud-based hardware security module (HSM) that enables you to generate and use your own encryption keys on the AWS Cloud
- The HSM in CloudHSM means: Hardware Security Module
- Enables you to easily generate and use your own encryption keys on the AWS Cloud 
- Encryption keys can be 128-bit or 256-bit
- Performs cryptographic operations using keys that you create and control in your own dedicated HSM appliance
- Securely stores cryptographic key material
- CloudHSM clients is installed and hosted in your EC2 instances
- The HSM cluster is deployed in your VPC
- Single tenant - only used by one tenant or user (you)
- Use cases: Offload SSL Processing, Enabling Transparent Data Encryption for Oracle databases, Protecting the private keys for an Issuing Certificate Authority (CA), and Securing Code Signing for Java and Windows

![Alt text](images/cloudhsm.png)