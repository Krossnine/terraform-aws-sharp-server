resource "aws_api_gateway_rest_api" "sharp_server_gw" {
  name = var.name

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  binary_media_types = [
    "*/*"
  ]
  tags = var.tags
}

resource "aws_api_gateway_deployment" "sharp_server_gw_deployment" {
  depends_on = [
    aws_api_gateway_method.sharp_server_root_method,
    aws_api_gateway_integration.sharp_server_root_integration,
    aws_api_gateway_method.sharp_server_proxy_method,
    aws_api_gateway_integration.sharp_server_proxy_integration,

  ]
  rest_api_id = aws_api_gateway_rest_api.sharp_server_gw.id
  stage_name  = var.name
}

#############################################################################
# Listen requests for root "/"
#############################################################################
resource "aws_api_gateway_method" "sharp_server_root_method" {
  rest_api_id   = aws_api_gateway_rest_api.sharp_server_gw.id
  resource_id   = aws_api_gateway_rest_api.sharp_server_gw.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "sharp_server_root_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sharp_server_gw.id
  resource_id             = aws_api_gateway_rest_api.sharp_server_gw.root_resource_id
  http_method             = aws_api_gateway_method.sharp_server_root_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.sharp_server_lambda.invoke_arn
}

#############################################################################
# Listen all requests except "/"
#############################################################################
resource "aws_api_gateway_resource" "sharp_server_proxy_resource" {
  rest_api_id = aws_api_gateway_rest_api.sharp_server_gw.id
  parent_id   = aws_api_gateway_rest_api.sharp_server_gw.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "sharp_server_proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.sharp_server_gw.id
  resource_id   = aws_api_gateway_resource.sharp_server_proxy_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "sharp_server_proxy_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sharp_server_gw.id
  resource_id             = aws_api_gateway_resource.sharp_server_proxy_resource.id
  http_method             = aws_api_gateway_method.sharp_server_proxy_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.sharp_server_lambda.invoke_arn
}
