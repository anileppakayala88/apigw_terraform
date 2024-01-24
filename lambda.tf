data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambdafunction.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "dynamodb-lambda" {
  function_name    = "dynamodb-lambda"
  runtime          = "python3.8"
  handler          = "lambdafunction.lambda_handler"
  filename         = "lambda_function_payload.zip"
  role             = aws_iam_role.lambda_execution_role.arn
  source_code_hash = data.archive_file.lambda.output_base64sha256

  environment {
    variables = {
      env     = var.env
      content = var.content
    }
  }
}