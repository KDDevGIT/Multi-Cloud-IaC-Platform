terraform {
  backend "s3" {
    bucket = "platform-bucket-897729126508-us-west-1-an" //manage on console
    key = "aws-prod/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "platform-table" 
    encrypt = true
  }
}