# AWS CloudFormation Templates for Practice

This repository contains AWS CloudFormation templates for personal learning and experimentation.

## 📦 Contents

- `alb-template.yml`  
  Template to create a public-facing Application Load Balancer (ALB) with HTTPS support and Route53 integration.  
  Uses existing VPC, subnets, hosted zone.

## 🚀 Usage

### 1. Prepare Parameters

Create a `params.json` file with your environment-specific values:

```json
[
  { "ParameterKey": "VpcId", "ParameterValue": "vpc-xxxxxxxx" },
  { "ParameterKey": "Subnet1", "ParameterValue": "subnet-aaaaaaa" },
  { "ParameterKey": "Subnet2", "ParameterValue": "subnet-bbbbbbb" },
  { "ParameterKey": "CertificateArn", "ParameterValue": "arn:aws:acm:..." },
  { "ParameterKey": "HostedZoneId", "ParameterValue": "Z2ABCDEFGHIJKL" },
  { "ParameterKey": "DomainName", "ParameterValue": "app.example.com" }
]
```

### 2. Deploy the Template

```bash
aws cloudformation deploy   --template-file alb.yaml   --stack-name my-alb-stack   --parameter-overrides file://params.json
```

## 🛠 Prerequisites

- AWS CLI configured with proper credentials
- Required resources (VPC, subnets, SG, target group, ACM cert, Route53 hosted zone) already exist

## 🎯 Purpose

This repository is for educational and personal practice use only.  
It is **not intended for production use**.

## 📚 References

- [AWS CloudFormation Docs](https://docs.aws.amazon.com/cloudformation/)
- [ALB User Guide](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- [Route53 Alias Records](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-elb-load-balancer.html)
