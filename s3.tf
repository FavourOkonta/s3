provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "Website" {
  bucket = "favour.com"
  acl    = "public-read"

  tags = {
    Name        = "Website"
    Environment = "production"
  }
website {
  index_document = "index.html"
}

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadForGetBucketObjects",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::favour.com/*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_object" "website_object" {
  acl        = "public-read"
  key        = "index.html"
  bucket     = "favour.com"
  source     = "index.html"
  content_type = "text/html"
}