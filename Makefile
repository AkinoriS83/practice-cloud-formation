STACK_PRIVATE_SUBNET = my-private-subnet-stack
STACK_ALB = my-alb-stack
STACK_AUTO_SCALING = my-auto-scaling-stack
# STACK_EC2 = my-ec2-stack

.PHONY: all network alb auto_scaling clean

all: private_subnet alb auto_scaling

private_subnet:
	aws cloudformation deploy \
		--template-file private_subnet.yaml \
		--stack-name $(STACK_PRIVATE_SUBNET) \
		--parameter-overrides \
			file://params_private_subnet.json

alb:
	aws cloudformation deploy \
		--template-file alb.yaml \
		--stack-name $(STACK_ALB) \
		--parameter-overrides \
			file://params_alb.json

auto_scaling:
	aws cloudformation deploy \
		--template-file atuo_scaling.yaml \
		--stack-name $(STACK_AUTO_SCALING) \
		--parameter-overrides \
			file://params_auto_scaling.json

# ec2:
# 	aws cloudformation deploy \
# 		--template-file ec2.yaml \
# 		--stack-name $(STACK_EC2) \
# 		--parameter-overrides \
# 			file://params_ec2.json

clean:
# aws cloudformation delete-stack --stack-name $(STACK_EC2)
# aws cloudformation wait stack-delete-complete --stack-name $(STACK_EC2)
	aws cloudformation delete-stack --stack-name $(STACK_AUTO_SCALING)
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_AUTO_SCALING)
	aws cloudformation delete-stack --stack-name $(STACK_ALB)
	aws cloudformation delete-stack --stack-name $(STACK_PRIVATE_SUBNET)
