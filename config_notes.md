### Install CLI for AWS and Azure
#### Install AWS CLI
```
winget install -e --id Amazon.AWSCLI
aws configure
aws sts get-caller-identity
```
#### Install Azure CLI
```
winget install -e --id Microsoft.AzureCLI
az login
az account show 
```
#### If you have issues with Azure CLI Install
```
az account clear
az config set core.enable_broker_on_windows=false
az login
az account show
```
## AWS
### Create AWS S3 Bucket (backend.tf)
#### Create Bucket
```
aws s3api create-bucket `
  --bucket TFSTATE-BUCKET-NAME `
  --region us-west-1 `
  --create-bucket-configuration LocationConstraint=us-west-1
```
#### Enable Versioning on Bucket
```
aws s3api put-bucket-versioning `
  --bucket TFSTATE-BUCKET-NAME `
  --versioning-configuration Status=Enabled
```
#### Enable Encryption on Bucket
```
aws s3api put-bucket-encryption `
  --bucket TFSTATE-BUCKET-NAME `
  --server-side-encryption-configuration '{
    "Rules": [
      {
        "ApplyServerSideEncryptionByDefault": {
          "SSEAlgorithm": "AES256"
        }
      }
    ]
  }'
```
  ### Create AWS DynamoDB Lock Table (backend.tf)
```
  aws dynamodb create-table `
  --table-name TF-LOCKS-TABLE-NAME `
  --attribute-definitions AttributeName=LockID,AttributeType=S `
  --key-schema AttributeName=LockID,KeyType=HASH `
  --billing-mode PAY_PER_REQUEST `
  --region us-west-1

```
## Azure
### Create Resource Group (backend.tf)
```
az group create --name YOUR-REAL-TFSTATE-RG --location westus
```
### Create Storage Account (backend.tf)
```
az storage account create `
  --name yourrealtfstatestorage `
  --resource-group YOUR-REAL-TFSTATE-RG `
  --location westus `
  --sku Standard_LRS `
  --encryption-services blob
```
### Create Container (backend.tf)
```
az storage container create `
  --name tfstate `
  --account-name yourrealtfstatestorage `
  --auth-mode login
```
## AWS Compute
### Grab AMI (environments/aws-prod/terraform.tfvars)
```
aws ssm get-parameters `
  --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64 `
  --region us-west-1
```
OR In AWS Console: 
1. Launch EC2 Instance
2. Select Amazon Linux 2023 or Amazon Linux 2
3.  Copy AMI ID