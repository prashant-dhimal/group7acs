module "vpc-dev" {
  source = "../../../modules/aws_network"
  #source              = "git@github.com:igeiman/aws_network.git"
  #env                 = var.env
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
  default_tags = merge(module.globalvars.default_tags, { "env" = var.env })
  prefix       = module.globalvars.prefix
  name_prefix = "${local.prefix}-${var.env}"
}