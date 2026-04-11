terraform {
  required_providers {
	aws = {
		source = "hashicorp/aws"
		version = "6.40.0"
	}
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "random" {
  # Configuration options
}

resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "test-bucket-${random_id.bucket_suffix.hex}"
}

output "bucket_name" {
  value = aws_s3_bucket.test_bucket.tags["Name"]
}