# Multi-Cloud-IaC-Platform
Platform using AWS and Azure respectively built using Terraform

- Production-ready application stack in AWS and Azure using Terraform. Stack Terraform (modules + remote state) 

- AWS (VPC, EC2, ALB, RDS) 

- Azure (VNet, VMSS, Azure SQL) 

- GitHub Actions CI/CD 

- Python for validation scripts

## Terraform.tfvars (Will not be pushed to Github)
### Environments/aws-prod/Terraform.tfvars
```
name       = "multicloud-platform"
aws_region = "us-west-1"
vpc_cidr   = "10.10.0.0/16"
ami_id = "ami-xxxxxxxxxxxxxxxxx" //example AMI

# db_username = "db_username"
# db_password should come from GH Secrets in CI or local env var usage
```
### Environments/azure-prod/Terraform.tfvars
```
name     = "multicloud-platform"
location = "westus"

vnet_cidr = ["10.20.0.0/16"]

public_subnet_prefixes  = ["10.20.1.0/24"]
private_subnet_prefixes = ["10.20.2.0/24"]

admin_username = "azureuser" //example
ssh_public_key = "public_ssh_key" //example
```


