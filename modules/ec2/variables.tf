# --- ./modules/ec2/variables.tf --- 

variable "base_name" {
  type        = string
  description = "The base name for the EC2 instance"
}

variable "ami" {
  type        = string
  default     = "ami-0b0af3577fe5e3532"
  description = "The AMI for the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The Instance Type for the EC2 instance"
}

variable "sub2_id" {
  type        = string
  description = "The ID of subnet 2, from the VPC Module"

}

variable "sub3_id" {
  type        = string
  description = "The ID of subnet 3, from the VPC Module"

}

variable "sub4_id" {
  type        = string
  description = "The ID of subnet 4, from the VPC Module"

}

variable "pub_ssh_sg" {
  type        = string
  description = "Imports the Public SSH Security Group"
}

variable "pub_http_sg" {
  type        = string
  description = "Imports the Public HTTP Security Group"
}

variable "alb_target_group_arn" {
  description = "Imports the ARN of the ALB Target Group from VPC"
}

variable "key_name" {
  description = "Imports name of SecretsManager managed Key"
}