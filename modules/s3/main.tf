# --- ./modules/s3/main.tf --- 

# Imports random string resource
resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

# Creates S3 bucket
resource "aws_s3_bucket" "s3" {
  bucket        = join("-", ["${var.base_name}-s3", random_string.random.result])
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id      = "img"
    enabled = true

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }

  lifecycle_rule {
    id      = "log"
    enabled = true

    expiration {
      days = 90
    }
  }
}