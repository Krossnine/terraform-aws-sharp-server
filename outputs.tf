output "sharp_server_cloudfront_url" {
  description = "The URL of the sharp server cloudfront"
  value       = "https://${aws_cloudfront_distribution.sharp_server_distribution.domain_name}"
}

output "sharp_server_api_gateway_url" {
  description = "The URL of the sharp server api gateway"
  value       = aws_api_gateway_deployment.sharp_server_gw_deployment.invoke_url
}