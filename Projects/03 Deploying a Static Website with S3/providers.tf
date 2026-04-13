terraform {
  required_version = "= 1.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.40.0"
    }
  }

  # backend "s3" {
  #   key     = "terraform.tfstate"
  #   bucket  = "terraform-practice-backend-bucket-009"
  #   region  = "us-east-1"
  #   encrypt = true
  # }
}

provider "aws" {
  region = "us-east-1"
}
