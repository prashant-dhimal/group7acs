
#Fetching networking details from s3
data "terraform_remote_state" "network" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "group7acs-staging"                           // Bucket from where to GET Terraform State
    key    = "network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                               // Region where bucket created
  }
}

#Importing global vars module
module "global_variable" {
  source = "../../../modules/globalvars"
}

#configuring variables for 
# Defining the tags  and variables locally using the modules
locals {
  default_tags       = merge(module.global_variable.default_tags, { "env" = var.env })
  prefix             = module.global_variable.prefix
  name_prefix        = "${local.prefix}-${var.env}"
  keyName            = "ssh_key_${var.env}"
  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  public_subnet_ids  = data.terraform_remote_state.network.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  target             = module.application_loadbalancing.target_full_name
  cloud_pub_ip       = module.global_variable.public_ip_cloud9
  cloud_pri_ip       = module.global_variable.private_cloud9_ip
  my_pub_ip          = module.global_variable.my_system_ip
}
# Security_Key for Both Bastion and Webserver
resource "aws_key_pair" "web_server" {
  key_name   = "${local.name_prefix}-Dev"
  public_key = file("${path.module}/${local.keyName}.pub")
}
# Data source for AMI id to be passed into the module
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Creation of Bastion Host
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.master_key.key_name
  subnet_id                   = local.public_subnet_ids[0]
  security_groups             = module.security_group_Bastion.Bastion_SG
  associate_public_ip_address = true
  ebs_optimized               = true
  monitoring                  = true
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  root_block_device {
    encrypted = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-BastionHost"
    }
  )
}

# Module of Security Group for Load Balancer
module "security_group_ALB" {
  source       = "../../../modules/aws_sg"
  env          = var.env
  type         = "LB"
  vpc_id       = local.vpc_id
  ingress_cidr = ["${local.my_pub_ip}/32"]
  egress_cidr  = [var.vpc_cidr]
  prefix       = local.prefix
  default_tags = local.default_tags
}

#Module for Security Group for EC2 Instances
module "security_group_EC2" {
  source       = "../../../modules/aws_sg"
  env          = var.env
  type         = "EC2"
  vpc_id       = local.vpc_id
  ingress_cidr = ["${local.my_pub_ip}/32", var.vpc_cidr, "0.0.0.0/0"]
  egress_cidr  = [var.vpc_cidr, "${local.my_pub_ip}/32", "0.0.0.0/0"]
  prefix       = local.prefix
  default_tags = local.default_tags
}


#Creation of Module for Bastion Host Security Group
module "security_group_Bastion" {
  source       = "../../../modules/aws_sg"
  env          = var.env
  type         = "Bastion"
  vpc_id       = local.vpc_id
  ingress_cidr = [var.vpc_cidr, "${local.cloud_pub_ip}/32", "${local.cloud_pri_ip}/32", "0.0.0.0/0"]
  egress_cidr  = [var.vpc_cidr, "${local.cloud_pub_ip}/32", "${local.cloud_pri_ip}/32"]
  prefix       = local.prefix
  default_tags = local.default_tags
}
#Creation of Ec2 Instances through Launch_Configuration
module "launch_configurations" {
  source            = "../../../modules/aws_launch_configuration"
  env               = var.env
  security_group_id = module.security_group_EC2.Ec2_SG
  key_name          = aws_key_pair.master_key.key_name
  ami_id            = data.aws_ami.latest_amazon_linux.id
  policy_iam        = var.iam_instance_profile_name
  instance_type     = lookup(var.instance_type, var.env)
  prefix            = local.prefix
  default_tags      = local.default_tags
}

#Module of ALB
module "application_loadbalancing" {
  source            = "../../../modules/aws_alb"
  env               = var.env
  vpc_id            = local.vpc_id
  public_subnets    = local.public_subnet_ids
  security_group_lb = module.security_group_ALB.LoadBalancer_SG
  prefix            = local.prefix
  default_tags      = local.default_tags
  target_group      = local.target

}




#Module for ASG"
module "autoscaling_group" {
  source               = "../../../modules/aws_auto_scaling"
  env                  = var.env
  minisize             = lookup(var.minsize, var.env)
  desiredcapacity      = lookup(var.desiredcapacity, var.env)
  maxsize              = lookup(var.maxsize, var.env)
  private_subnet       = local.private_subnet_ids
  launch-configuration = module.launch_configurations.LaunchConfigurationName
  target_group_arn     = module.application_loadbalancing.target_full_name
  threshold_scale_down = 5
  threshold_scale_up   = 10
  prefix               = local.prefix
  default_tags         = local.default_tags
}

# Adding SSH key to Amazon EC2 and bastion
resource "aws_key_pair" "master_key" {
  key_name   = local.name_prefix
  public_key = file("${path.module}/${local.keyName}.pub")
}
