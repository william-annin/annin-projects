provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Owner       = "Will"
      Provisioner = "Terraform"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}