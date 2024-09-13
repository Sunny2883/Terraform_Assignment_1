resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name         = "react-app-bucket-assignment-1.s3-website.ap-south-1.amazonaws.com"
    origin_id           = "s3-website-origin"
    
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"  # Use HTTP only for origin communication
      origin_ssl_protocols   = ["TLSv1.2"]  # For HTTPS between CloudFront and viewers
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for React app"
  default_root_object = "index.html"

  # Logging configuration can be added here if needed

  aliases = ["*.sunnykumar.publicvm.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-website-origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"  # Redirect HTTP to HTTPS
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  price_class = "PriceClass_100"  # Adjust if you want more or fewer regions

  restrictions {
    geo_restriction {
      restriction_type = "none"  # No geographic restrictions
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:396608771618:certificate/82ed56de-b8be-463e-bf43-1331b018b205"  # Your custom SSL certificate
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"  # Use the latest TLS version
  }

  # Optional: Enable Web Application Firewall (WAF) if required
  # web_acl_id = "your-waf-web-acl-id" # Uncomment and replace with your WAF ID if using AWS WAF
}
