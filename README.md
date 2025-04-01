# ☁️ AWS CloudFormation Practice Environment

This repository contains modular AWS CloudFormation templates to build a basic infrastructure setup consisting of:

- 🔐 VPC + Private Subnet + NAT Gateway
- 🌐 Application Load Balancer (ALB)
- 🖥️ EC2 or Auto Scaling Group
- 🛠️ Makefile-based deployment automation

---

## 📂 Files Overview

| File | Purpose |
|------|---------|
| `private_subnet.yaml` | Defines VPC, private subnet, NAT Gateway, and route table |
| `alb.yaml` | Creates ALB and associated security group |
| `ec2.yaml` | Launches EC2 instance and registers it to a target group |
| `atuo_scaling.yaml` | (Optional) Defines Auto Scaling Group |
| `Makefile` | Automates deploy/delete operations for all stacks |

---

## 🚀 Deployment (Using Make)

Make sure your AWS CLI is configured and run:

```bash
# Deploy all stacks in order: network → alb → ec2
make all

# Delete all stacks safely, in reverse order (includes wait for deletion)
make clean
```

---

## 🔧 Parameter Configuration

Each template uses parameters like `VpcId`, `PrivateSubnetId`, `AlbSecurityGroupId`, `AmiId`, etc.

These are resolved via CloudFormation `Export`/`ImportValue`, so make sure the dependencies are created first (via Makefile or manually).

To deploy `ec2.yaml` standalone, pass parameters like this:

```bash
aws cloudformation deploy \
  --template-file ec2.yaml \
  --stack-name my-ec2-stack \
  --parameter-overrides AmiId=ami-xxxxxxxxxxxxxxxxx
```

---

## 🧠 Tips

- Availability Zone (AZ) for private subnet can be optionally specified. If omitted, the first AZ will be selected automatically.
- `delete-stack` is non-blocking, so `wait stack-delete-complete` is used in Makefile to avoid dependency errors.
- `Makefile` defines proper stack dependencies to ensure correct deploy/delete order.

---

## 📚 References

- [AWS CloudFormation](https://docs.aws.amazon.com/cloudformation/)
- [ALB User Guide](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- [Auto Scaling Group Docs](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html)

---

> This repository is intended for **learning and practice only**, not for production.
