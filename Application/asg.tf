module "asg" {
  source = "../modules/asg"

  env_code            = var.env_code
  instance_type       = var.instance_type
  ami                 = var.ami
  image_name          = var.image_name
  vpc_zone_identifier = data.terraform_remote_state.wordpress-network-level.outputs.subnet_id_private
  lb-sg               = module.lb.lb-sg
  vpc_id              = data.terraform_remote_state.wordpress-network-level.outputs.vpc-id
  target-group        = module.lb.target-arn
  rds_endpoint        = module.rds.rds_endpoint
  db_username         = var.db_username
  db_name             = var.db_name
  rds_password        = local.rds_password
}
