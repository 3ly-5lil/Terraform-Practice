data "aws_iam_policy_document" "assume_role_policy" {
  version = "2012-10-17"
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "ssm.amazonaws.com",
        "logs.amazonaws.com",
        "ec2.amazonaws.com",
        "elasticbeanstalk.amazonaws.com",
        "dynamodb.amazonaws.com",
        "s3.amazonaws.com",
        "cloudfront.amazonaws.com",
        "cloudtrail.amazonaws.com",
        "events.amazonaws.com",
        "cloud9.amazonaws.com",
        "kms.amazonaws.com",
        "autoscaling.amazonaws.com",
        "rds.amazonaws.com",
        "sqs.amazonaws.com",
        "sns.amazonaws.com",
        "resource-groups.amazonaws.com",
        "cloudformation.amazonaws.com",
        "elasticloadbalancing.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "LabRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = {
    "cloudlab" = "c203865a5200625l14544807t1w623933043284"
  }
}
