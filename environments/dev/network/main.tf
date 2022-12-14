module "vpc-dev" {
  source = "../../../modules/aws_network"
  #source              = "git@github.com:igeiman/aws_network.git"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  private_cidr_blocks = var.public_subnet_cidrs
  prefix              = var.prefix
  default_tags        = var.default_tags
}