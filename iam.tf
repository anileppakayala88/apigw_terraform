resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

}

data "aws_iam_policy_document" "dynamo_policy" {
  statement {
    effect = "Allow"
    actions = ["dynamodb:GetItem"]
    resources = ["arn:aws:dynamodb:eu-east-1:012029368059:table/my_terrafrom_table"]
  }
  
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_execution_role.name

}

resource "aws_iam_role_policy_attachment" "dynamodb_access_role" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = aws_iam_role.lambda_execution_role.name

}

resource "aws_iam_role_policy" "lamdba_dynamo_policy" {
  name = "lamdba_dynamo_policy"
  role = aws_iam_role.lambda_execution_role.name
  policy = data.aws_iam_policy_document.dynamo_policy.json
}