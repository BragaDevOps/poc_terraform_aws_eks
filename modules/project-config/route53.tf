resource "aws_route53_zone" "main" {
  name = var.DOMAIN
  force_destroy = true
}