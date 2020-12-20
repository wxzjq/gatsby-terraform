resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = local.s3_bucket_name

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

data "template_file" "s3_bucket_policy" {
  template = file("policies/bucket.json.tpl")

  vars = {
    bucket_arn = aws_s3_bucket.my_bucket.arn
    ref_key = local.referer_key
  }
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  depends_on = [
  aws_s3_bucket_public_access_block.my_bucket_public_access_block]
  bucket = aws_s3_bucket.my_bucket.id
  policy = data.template_file.s3_bucket_policy.rendered
}