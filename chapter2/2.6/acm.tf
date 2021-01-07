resource "aws_acm_certificate" "example" {
  domain_name       = "*.hi1280.com" # 変更箇所
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}