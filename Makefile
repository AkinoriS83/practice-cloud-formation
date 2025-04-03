STACK_PRIVATE_SUBNET = my-private-subnet-stack
STACK_ALB = my-alb-stack
STACK_AUTO_SCALING = my-auto-scaling-stack

.PHONY: all network alb auto_scaling clean

all: private_subnet alb auto_scaling

private_subnet:
	aws cloudformation deploy \
		--template-file template/private_subnet.yaml \
		--stack-name $(STACK_PRIVATE_SUBNET) \
		--parameter-overrides \
			file://params/private_subnet.json

alb:
	aws cloudformation deploy \
		--template-file template/alb.yaml \
		--stack-name $(STACK_ALB) \
		--parameter-overrides \
			file://params/alb.json

auto_scaling:
	aws cloudformation deploy \
		--template-file template/atuo_scaling.yaml \
		--stack-name $(STACK_AUTO_SCALING) \
		--parameter-overrides \
			file://params/auto_scaling.json


clean:
	aws cloudformation delete-stack --stack-name $(STACK_AUTO_SCALING)
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_AUTO_SCALING)
	aws cloudformation delete-stack --stack-name $(STACK_ALB)
	aws cloudformation delete-stack --stack-name $(STACK_PRIVATE_SUBNET)
