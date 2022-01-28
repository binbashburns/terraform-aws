# --- ./main.tf --- 

# Invokes VPC module
module "vpc" {
  source    = "./modules/vpc"
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
}

# # Invokes S3 module
# module "s3" {
#   source      = "./modules/s3"
#   base_name   = var.base_name
# }