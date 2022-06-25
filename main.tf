provider "aws" {
  region = var.region
}
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  block_public_acls   = true
  block_public_policy = true
  force_destroy = var.bucket_force_destroy
  versioning {
    enabled = var.bucket_versioning
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.bucket_encryption_algorithm
      }
    }
  }
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = var.dynamodb_table_billing_mode
  hash_key     = var.dynamodb_table_hash_key
  attribute {
    name = var.dynamodb_table_attribute_name
    type = var.dynamodb_table_attribute_type
  }
}