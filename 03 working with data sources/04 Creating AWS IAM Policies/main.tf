data "aws_iam_policy_document" "s3_read_only" {
  version = "2012-10-17"

  statement {
    sid    = "S3Read"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    resources = [
      "arn:aws:s3:::*/*"
    ]

    actions = [
      "s3:GetObject"
    ]

  }
  
  statement {
    sid    = "S3List"
  }
}
