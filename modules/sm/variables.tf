variable "description" {
  default     = "ssh key"
  description = "Description of secret"
  type        = string
}

variable "base_name" {
  type        = string
  description = "The base name for the S3 bucket"
}