output "website_link" {
  value       = aws_s3_bucket_website_configuration.main.website_endpoint
  description = "The link to the hosted website"
}
