output "bucket_id" {
  value       = aws_s3_bucket.test.id
  description = "The id of the created bucket"
  depends_on  = [aws_s3_bucket.test]
}
