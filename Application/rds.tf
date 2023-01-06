module "rds" {
  source = "../modules/rds"

  subnet_ids            = data.terraform_remote_state.wordpress-network-level.outputs.subnet_id_private
  env_code              = var.env_code
  vpc_id                = data.terraform_remote_state.wordpress-network-level.outputs.vpc-id
  source_Security_group = module.asg.security_group_id
  rds_password          = local.rds_password
  db_username           = var.db_username
  db_name               = var.db_name
}

