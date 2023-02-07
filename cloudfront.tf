locals {
  use_default_cert = var.custom_certificate_arn == null
}

resource "aws_cloudfront_distribution" "sharp_server_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = var.cloudfront_price_class
  comment             = "${var.name} CloudFront Distribution"
  tags                = var.tags
  wait_for_deployment = var.wait_for_deployment
  aliases             = var.custom_domain_name == null ? [] : [var.custom_domain_name]

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
    min_ttl                = var.cache_ttl
    default_ttl            = var.cache_ttl
    max_ttl                = var.cache_ttl
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
    acm_certificate_arn            = local.use_default_cert ? null : var.custom_certificate_arn
    minimum_protocol_version       = local.use_default_cert ? null : var.custom_certificate_protocol_version
    ssl_support_method             = local.use_default_cert ? null : "sni-only"
    cloudfront_default_certificate = local.use_default_cert
  }
}
