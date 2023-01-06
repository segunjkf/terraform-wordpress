module "ncd" {
  source      = "../modules/network-content-delivery"
  lb-dns-name = module.lb.lb-dns-name
}

