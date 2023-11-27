# AWS Firewall Manager

- Manage rules in all accounts of an AWS Organization
- You can enable AWS WAF rules, AWS Shield Advanced protection, security groups, AWS Network Firewall rules, and Amazon Route 53 Resolver DNS Firewall rules.

- Security policy: common set of security rules
    - WAF rules (ALB, API Gateway, CloudFront
    - Shield Advanced rules (ALB, CLB, NLB, Elastic IP, CloudFront)
    - Security Groups for EC2, ALB and ENI resources in VPC
    - AWS Network Firewall rules (VPC)
    - Amazon Route 53 Resolver DNS Firewall rules (VPC)
    - Policies are created at the regional level