output "aws_lambda_function_url" {
  value       = aws_lambda_function_url.this.function_url
  description = "The function url used to invoke the lambda function"
}
