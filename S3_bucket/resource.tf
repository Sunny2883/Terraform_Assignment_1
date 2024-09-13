

# Define the S3 bucket
resource "aws_s3_bucket" "asdfghuy" {
  bucket = "react-app-bucket-assignment-1"

  tags = {
    Name = "React App Bucket"
  }
}

# Enforce Object Ownership using aws_s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "asdfghuy" {
  bucket = aws_s3_bucket.asdfghuy.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Enable website hosting using the aws_s3_bucket_website_configuration resource
resource "aws_s3_bucket_website_configuration" "asdfghuy" {
  bucket = aws_s3_bucket.asdfghuy.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Disable block public access settings
resource "aws_s3_bucket_public_access_block" "asdfghuy" {
  bucket = aws_s3_bucket.asdfghuy.id

  block_public_acls   = false
  ignore_public_acls  = false
  block_public_policy = false
  restrict_public_buckets = false
}

# Define the S3 bucket policy to allow public read access
resource "aws_s3_bucket_policy" "asdfghuy" {
  bucket = aws_s3_bucket.asdfghuy.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.asdfghuy.bucket}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.asdfghuy]
}