STACK_VPC = my-vpc-stack
STACK_PRIVATE_SUBNET = my-private-subnet-stack
STACK_ALB = my-alb-stack
STACK_AUTO_SCALING = my-auto-scaling-stack
STACK_CODE_DEPLOY = my-code-deploy-stack
STACK_CODE_PIPE_LINE = my-code-pipe-line-stack

.PHONY: all vpc network alb auto_scaling code_deploy code_pipe_line clean

all: code_pipe_line

code_pipe_line: code_deploy
	aws cloudformation deploy \
		--template-file template/code_pipe_line.yaml \
		--stack-name $(STACK_CODE_PIPE_LINE) \
		--capabilities CAPABILITY_NAMED_IAM \
		--parameter-overrides \
			file://params/code_pipe_line.json

code_deploy: auto_scaling
	aws cloudformation deploy \
		--template-file template/code_deploy.yaml \
		--stack-name $(STACK_CODE_DEPLOY) \
		--capabilities CAPABILITY_NAMED_IAM

auto_scaling: private_subnet alb
	aws cloudformation deploy \
		--template-file template/auto_scaling.yaml \
		--stack-name $(STACK_AUTO_SCALING) \
		--capabilities CAPABILITY_NAMED_IAM \
		--parameter-overrides \
			file://params/auto_scaling.json

alb: vpc
	aws cloudformation deploy \
		--template-file template/alb.yaml \
		--stack-name $(STACK_ALB) \
		--parameter-overrides \
			file://params/alb.json

private_subnet: vpc
	aws cloudformation deploy \
		--template-file template/private_subnet.yaml \
		--stack-name $(STACK_PRIVATE_SUBNET) \
		--parameter-overrides \
			file://params/private_subnet.json

vpc:
	aws cloudformation deploy \
		--template-file template/vpc.yaml \
		--stack-name $(STACK_VPC) \
		--parameter-overrides \
			file://params/vpc.json


clean:
	aws cloudformation delete-stack --stack-name $(STACK_CODE_PIPE_LINE)
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_CODE_PIPE_LINE)
	aws cloudformation delete-stack --stack-name $(STACK_CODE_DEPLOY)
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_CODE_DEPLOY)
	aws cloudformation delete-stack --stack-name $(STACK_AUTO_SCALING)
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_AUTO_SCALING)
	aws cloudformation delete-stack --stack-name $(STACK_ALB)
	aws cloudformation delete-stack --stack-name $(STACK_PRIVATE_SUBNET)
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_ALB)
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_PRIVATE_SUBNET)
	aws cloudformation delete-stack --stack-name $(STACK_VPC)
