variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "bucket_versioning" {
  description = "Versioning status of the S3 bucket"
  type        = string

  validation {
    condition     = var.bucket_versioning == "Enabled" || var.bucket_versioning == "Disabled"
    error_message = "bucket_versioning must be either 'Enabled' or 'Disabled'."
  }
}