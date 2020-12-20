provider "aws" {
  region = local.region
}

locals {
  s3_bucket_name        = "skies-v1"
  primary_domain_name   = "www.skies.dev"
  alternate_domain_name = "skies.dev"
  region                = "us-east-1"
  referer_key           = "wQiCxJVmq0XZV99ZIvysnlwvv89QUxnOjRIa"
  cloudfront_ttl        = 31536000
}

data "aws_caller_identity" "current" {}
