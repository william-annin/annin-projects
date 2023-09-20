terraform {
  backend "s3" {
    bucket  = "swamp-terraform-state"
    key     = "prod/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    #dynamodb_table = "swamp-terraform-state-lock"
  }
}