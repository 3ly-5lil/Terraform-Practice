terraform {
  required_version = "= 1.14.8"

  required_providers {
    aws = {
      version = "~>6.40.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    encrypt = true
    region  = "us-east-1"
    bucket  = "terraform-proj-backend-bucket"
  }
}

provider "aws" {
  region = "us-east-1"
}
