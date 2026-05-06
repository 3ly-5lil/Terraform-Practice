resource "aws_s3_bucket" "new" {
	bucket = "terraform-state-bucket-9876543"
}

import {
	to = aws_s3_bucket.new
	identity = {
		bucket = "terraform-state-bucket-9876543"
	}
}