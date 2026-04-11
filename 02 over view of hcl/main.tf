terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}



resource "aws_s3_bucket" "test" {
	bucket = var.bucket_name
}

