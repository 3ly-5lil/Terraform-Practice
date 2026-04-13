locals {
  bucket_id  = "website-hosting-bucket-721509"
  bucket_arn = "arn:aws:s3:::website-hosting-bucket-721509"

  generic_tags = {
    "ManagedBy" = "Terraform"
    "Project"   = "Static Website on S3"
  }
}
#! Creating the S3 bucket required getting its info after, and in the lab environment with no admin access, it throw is (user not authorized to perform: s3:GetBucketObjectLockConfiguration on the resource)
#? Workaround: Create the bucket manually, and use the bucket id instead
/*
resource "aws_s3_bucket" "main" {
  bucket = local.bucket_id
	object_lock_enabled = false
}
*/

resource "aws_s3_bucket_website_configuration" "main" {
  bucket = local.bucket_id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "pages" {
  bucket = local.bucket_id

  for_each = toset(["index.html", "error.html"])
  key      = each.value
  source   = "./build/${each.value}"

  content_type = "text/html"
}

resource "aws_s3_bucket_public_access_block" "allow_public_access" {
  bucket = local.bucket_id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "main" {
  bucket = local.bucket_id
  policy = data.aws_iam_policy_document.allow_access_for_anyone.json
}

data "aws_iam_policy_document" "allow_access_for_anyone" {
  version = "2012-10-17"
  statement {
    sid    = "AllowPublicReadAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]


    resources = ["${local.bucket_arn}/*"]
  }
}
