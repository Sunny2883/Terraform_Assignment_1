output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.react-app-bucket-assignment-1.bucket_domain_name
}
