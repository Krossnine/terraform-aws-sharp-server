SHELL := /bin/bash
MAKEFLAGS += --no-print-directory

clean:
	@rm -rf ./examples/.terraform ./examples/.terraform.lock.hcl

init:
	@terraform -chdir=./examples init

apply:init
	@terraform -chdir=./examples apply --auto-approve

destroy:init
	@terraform -chdir=./examples destroy --auto-approve

output:
	@terraform -chdir=./examples output

update-docs:
	@terraform-docs markdown table --output-file readme.md --output-mode inject .