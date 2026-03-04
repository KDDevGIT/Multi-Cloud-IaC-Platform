TF ?= terraform

fmt:
	$(TF) fmt -recursive

validate:
	$(TF) fmt -check -recursive
	cd environments/aws-prod && $(TF) init -input=false && $(TF) validate
	cd environments/azure-prod && $(TF) init -input=false && $(TF) validate

plan-aws:
	cd environments/aws-prod && $(TF) init -input=false && $(TF) plan

plan-azure:
	cd environments/azure-prod && $(TF) init -input=false && $(TF) plan