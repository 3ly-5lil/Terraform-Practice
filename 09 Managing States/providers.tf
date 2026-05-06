terraform {
  required_version = "~> 1.14.8"

  required_providers {
    aws = {
      version = "~> 6.43"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
