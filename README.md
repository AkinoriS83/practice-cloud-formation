# ☁️ AWS CloudFormation Practice Environment

This repository contains modular AWS CloudFormation templates to build a basic but extensible AWS infrastructure setup, including CI/CD deployment using CodeDeploy and CodePipeline.

## 🏗️ Architecture Overview

- 🔐 VPC + Private Subnet + NAT Gateway
- 🌐 Application Load Balancer (ALB)
- 🖥️ EC2 instance or Auto Scaling Group
- 🚀 CI/CD with CodeDeploy & CodePipeline
- 🛠️ Makefile-based deployment automation

---

## 📂 Files Overview

| File | Purpose |
|------|---------|
| `template/vpc.yaml` | Creates a basic VPC |
| `template/private_subnet.yaml` | Defines a private subnet, route table, NAT Gateway |
| `template/private_subnet_multi_nat.yaml` | A template with redundant NAT Gateway from private_subnet.yaml. |
| `template/alb.yaml` | Creates ALB and related security groups |
| `template/ec2.yaml` | Launches EC2 instance and registers it to a target group |
| `template/auto_scaling.yaml` | Defines Auto Scaling Group (optional) |
| `template/code_deploy.yaml` | Sets up CodeDeploy application and deployment group |
| `template/code_pipe_line.yaml` | Defines CodePipeline connected to GitHub |
| `params/vpc.json.example` | Example parameter file for deploying VPC template |
| `Makefile` | Automates deploy/delete operations for all stacks |

---

## 🚀 Deployment (Using Make)

Make sure your AWS CLI is configured and run:

```bash
# Deploy all stacks in order: vpc → subnet → alb → auto_scaling...
make all

# Clean up all stacks safely in reverse order
make clean
```

To deploy a specific stack manually:

```bash
aws cloudformation deploy \
  --template-file template/ec2.yaml \
  --stack-name my-ec2-stack \
  --parameter-overrides AmiId=ami-xxxxxxxxxxxxxxxxx
```

---

## 🔧 Parameter Configuration

Each template uses parameters like `VpcId`, `PrivateSubnetId`, `TargetGroupArn`, etc.

These parameters are often resolved via CloudFormation `Export`/`ImportValue`. You can override them using parameter files (see `params/*.json.example`) or CLI flags.

---

## 🧠 Tips

- Makefile includes proper stack dependencies to ensure correct deployment and deletion order.
- `delete-stack` is non-blocking; `wait` is included in Makefile to handle this.
- CodePipeline requires GitHub token configuration (see `code_pipe_line.yaml`).

---

## 📚 References

- [AWS CloudFormation](https://docs.aws.amazon.com/cloudformation/)
- [ALB User Guide](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- [CodeDeploy Docs](https://docs.aws.amazon.com/codedeploy/latest/userguide/welcome.html)
- [CodePipeline Docs](https://docs.aws.amazon.com/codepipeline/latest/userguide/welcome.html)

---

> ⚠️ This repository is intended for **learning and practice only**, not for production use.
