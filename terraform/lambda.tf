resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = file("policies/redirect.json")
}

locals {
  lambda_redirect_zip = "../lambda/redirect/dist/redirect.zip"
}

data "archive_file" "redirect_zip" {
  type        = "zip"
  source_file = "../lambda/redirect/index.js"
  output_path = local.lambda_redirect_zip
}

resource "aws_lambda_function" "redirect_lambda" {
  filename         = local.lambda_redirect_zip
  function_name    = "CloudFrontRedirect"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(local.lambda_redirect_zip)
  publish          = true
  runtime          = "nodejs12.x"
}

resource "aws_lambda_permission" "allow_cloudfront" {
  statement_id  = "AllowExecutionFromCloudFront"
  action        = "lambda:GetFunction"
  function_name = aws_lambda_function.redirect_lambda.function_name
  principal     = "edgelambda.amazonaws.com"
}
