# --- ./modules/s3/variables.tf --- 

variable "base_name" {
  type        = string
  description = "The base name for the S3 bucket"
}

variable "kms_key_arn" {
  description = "The KMS Key ARN"
}