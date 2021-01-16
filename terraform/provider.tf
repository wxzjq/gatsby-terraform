provider "aws" {
  region = local.region

}

locals {
  s3_bucket_name        = "bitcloudify.com"
  primary_domain_name   = "www.bitcloudify.com"
  alternate_domain_name = "bitcloudify.com"
  region                = "us-east-1"
  referer_key           = "wQiCxJVmq0XZV99ZIvysnlwvv89QUxnOjRIa"
  cloudfront_ttl        = 31536000
}

data "aws_caller_identity" "current" {}
