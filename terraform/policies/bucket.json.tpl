{
  "Version": "2012-10-17",
  "Id": "MyBucketPolicy",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${bucket_arn}/*",
      "Condition": {
        "StringLike": {"aws:Referer": "${ref_key}" }
      }
    }
  ]
}