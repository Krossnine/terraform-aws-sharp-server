
locals {
  api_gateway_url = replace(aws_api_gateway_deployment.sharp_server_gw_deployment.invoke_url, "/${var.name}", "")
}