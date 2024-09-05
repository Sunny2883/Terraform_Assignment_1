
resource "aws_s3_bucket" "react-app-bucket-assignment-1" {
  bucket = var.bucket_name

  # Enable static website hosting
  website {
    index_document = var.index_document
    error_document = var.error_document
  }
}

resource "aws_s3_bucket_policy" "react_app_bucket_policy" {
  bucket = aws_s3_bucket.react-app-bucket-assignment-1.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.react-app-bucket-assignment-1.arn}/*"
      }
    ]
  })
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.react-app-bucket-assignment-1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}