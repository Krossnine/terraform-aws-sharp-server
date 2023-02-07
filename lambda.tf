locals {
  lambda_zip = "${path.module}/versions/sharp-server-${var.sharp_server_version}.zip"
}

resource "aws_lambda_function" "sharp_server_lambda" {
  filename         = local.lambda_zip
  function_name    = var.name
  role             = aws_iam_role.api_lambda_role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(local.lambda_zip)
  runtime          = "nodejs16.x"
  timeout          = "30"
  memory_size      = var.memory
  environment {
    variables = {
      NODE_ENV  = "production"
      LOG_LEVEL = var.log_level
    }
  }
  tags = var.tags
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sharp_server_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.sharp_server_gw.execution_arn}/*/*"
}
