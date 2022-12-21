### Module to Create a AWS Launch Configuration

# Step 1 - Define the provider
provider "aws" {
  region = "us-east-1"
  
  
  
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Local variables
locals {
  default_tags = merge(
    var.default_tags,
    { "Env" = var.env }
  )
  name_prefix = "${var.prefix}-${var.env}"
}

# Launch configuration for Group 7
resource "aws_launch_configuration" "launch_configuration" {
  security_groups             = var.security_group_id
  key_name                    = var.key_name
  image_id                    = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = false
  iam_instance_profile        = var.policy_iam
  user_data = templatefile("${path.module}/install_httpd_webserver.sh.tpl",
    {
      env       = lower(var.env),
      prefix    = local.name_prefix
      owner     = lookup(var.default_tags, "Owner")
      studentId = lookup(var.default_tags, "StudentIds")
      app       = lookup(var.default_tags, "App")
    }
  )
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

  name_prefix = "${local.name_prefix}-LaunchConfiguration-Amazon-Linux"
}