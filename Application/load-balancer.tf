module "lb" {
  source = "../modules/load-balancer"

  env_code = var.env_code
  vpc_id   = data.terraform_remote_state.wordpress-network-level.outputs.vpc-id
  subnets  = data.terraform_remote_state.wordpress-network-level.outputs.subnet_id_public
  acm-arn  = module.ncd.acm-cert-arn
}

