import {
  to = aws_lambda_function.this
  identity = {
    function_name = "hellow-world"
  }
}

import {
  to = aws_iam_role.this
  identity = {
    name = "LabRole"
  }
}

import {
  to = aws_cloudwatch_log_group.this
  identity = {
    name = "/aws/lambda/hellow-world"
  }
}