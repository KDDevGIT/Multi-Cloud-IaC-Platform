terraform {
  backend "s3" {
    bucket = "BUCKET_NAME_TFSTATE" 
    key = "aws-prod/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "TF_LOCKS_TABLE" 
    encrypt = true
  }
}