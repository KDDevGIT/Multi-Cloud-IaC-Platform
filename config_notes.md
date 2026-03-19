### Istall CLI for AWS and Azure
- install AWS CLI: winget install -e --id Amazon.AWSCLI
- aws configure
- aws sts get-caller-identity

- install Azure CLI: winget install -e --id Microsoft.AzureCLI
- az login
- az account show 

### If you have issues with Azure
- az account clear
- az config set core.enable_broker_on_windows=false
- az login
- az account show

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