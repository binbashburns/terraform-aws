# --- ./main.tf --- 

# Invokes VPC module
module "vpc" {
  source    = "./modules/vpc"
  base_name = var.base_name
}

# Invokes Secret Manager module
module "sm" {
  source    = "./modules/sm"
  base_name = var.base_name
}

# Invokes EC2 module
module "ec2" {
  source               = "./modules/ec2"
  base_name            = var.base_name
  sub2_id              = module.vpc.sub2
  sub4_id              = module.vpc.sub4
  pub_ssh_sg           = module.vpc.pub_ssh_sg
  pub_http_sg          = module.vpc.pub_http_sg
  alb_target_group_arn = module.vpc.alb_target_group_arn
  key_name             = module.sm.key_name
}

# Invokes KMS module (Used to encrypt S3 bucket)
module "kms" {
  source = "./modules/kms"
}

# Invokes S3 module
module "s3" {
  source      = "./modules/s3"
  base_name   = var.base_name
  kms_key_arn = module.kms.kms_key_arn
}