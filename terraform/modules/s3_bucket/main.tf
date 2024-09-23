resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name}-${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = var.bucket_versioning
  }
}


output "bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}
