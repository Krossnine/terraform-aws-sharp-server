output "sharp_server_cloudfront_url" {
  description = "The URL of the sharp server cloudfront"
  value       = module.sharp_server.sharp_server_cloudfront_url
}

output "sharp_server_api_gateway_url" {
  description = "The URL of the sharp server api gateway"
  value       = module.sharp_server.sharp_server_api_gateway_url
}