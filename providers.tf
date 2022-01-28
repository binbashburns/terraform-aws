# --- ./providers.tf --- 

# Provides configuration details for Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.72.0"
    }
  }
}

# Provides configuration details for the AWS Terraform provider. 
provider "aws" {
  region = "us-east-1"
}