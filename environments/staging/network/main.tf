module "vpc-staging" {
  source              = "../../../modules/aws_network"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  private_cidr_blocks = var.private_subnet_cidrs
  prefix              = var.prefix
  default_tags        = var.default_tags
  public_cidr_blocks  = var.public_subnet_cidrs

}

# Global Variable module
module "global_variable" {
  source = "../../../modules/globalvars"
}

#COnfiguring tags with global variable 
locals {
  default_tags = merge(module.global_variable.default_tags, { "env" = var.env })
  prefix       = module.global_variable.prefix
  name_prefix  = "${local.prefix}-${var.env}"
}
Footer
© 2022 GitHub, Inc.
Footer navigation
Terms