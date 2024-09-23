

module "s3_bucket" {
  source = "../modules/s3_bucket"

  bucket_name       = "tfstate-bucket"
  bucket_versioning = "Disabled"
}
