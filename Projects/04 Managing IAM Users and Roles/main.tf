terraform {
  required_version = "~> 1.14.8"

  required_providers {
    aws = {
      version = "~> 6.42"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
}
