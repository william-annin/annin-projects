output "s3_bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}