output "public_subnet_ids" {
  value = module.vpc-prod.public_subnet_ids
}

output "vpc_id" {
  value = module.vpc-prod.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc-prod.private_subnet_ids
}