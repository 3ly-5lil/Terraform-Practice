output "policy_document" {
  value = data.aws_iam_policy_document.s3_read_only.json
}
