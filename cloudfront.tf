resource "aws_cloudfront_distribution" "sharp_server_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_200"
  comment             = "${var.name} CloudFront Distribution"
  tags                = var.tags
  wait_for_deployment = false

  origin {
    domain_name = replace(local.api_gateway_url, "https://", "")
    origin_id   = "sharp_server_api_gateway"
    origin_path = "/${var.name}"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "https-only"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_keepalive_timeout = 10
    }
  }

  default_cache_behavior {
    allowed_methods  = ["HEAD", "GET", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "sharp_server_api_gateway"

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.sharp_server_cache_ttl
    default_ttl            = var.sharp_server_cache_ttl
    max_ttl                = var.sharp_server_cache_ttl
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
