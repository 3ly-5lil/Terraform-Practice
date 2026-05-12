data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/build/index.mjs"
  output_path = "${path.module}/build/lambda.zip"
}

resource "aws_lambda_function" "this" {
  architectures = ["x86_64"]

  code_sha256 = data.archive_file.lambda_zip.output_base64sha256
  filename    = data.archive_file.lambda_zip.output_path

  package_type  = "Zip"
  function_name = "hellow-world"
  description   = "A starter AWS Lambda function."
  handler       = "index.handler"
  runtime       = "nodejs22.x"
  role          = aws_iam_role.this.arn
  skip_destroy  = false

  tags = {
    "lambda-console:blueprint" = "hello-world"
  }

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/hellow-world"
  }
}

resource "aws_lambda_function_url" "this" {
  authorization_type = "NONE"
  function_name      = aws_lambda_function.this.function_name
}
