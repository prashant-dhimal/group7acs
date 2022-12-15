# Step 1 - Define the provider
provider "aws" {
  region = "us-east-1"
}

# Availability_zone
data "aws_availability_zones" "available" {
  state = "available"
}
# Local variables
# Local variables
locals {
  default_tags = merge(
    var.default_tags,
    { "gname" = var.gname }
  )
  name_prefix = "${var.prefix}-${var.gname}"
}
#Loadbalancer

resource "aws_lb" "loadbalancer_g7" {
  name               = "${local.name_prefix}-LoadBalancer"
  security_groups    = var.security_group_lb
  subnets            = var.public_subnets
  load_balancer_type = "application"
  internal           = false
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-LoadBalancer"
    }
  )
}

#Load Balancer Listner
resource "aws_lb_listener" "lblistner_g7" {
  load_balancer_arn = aws_lb.loadbalancer_g7.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = var.target_group_g7

  }
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-LB_Listener"
    }
  )
}