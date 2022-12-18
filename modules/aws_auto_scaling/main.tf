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


# Creating auto_scaling _group
resource "aws_autoscaling_group" "webserver_group_7" {
  name_prefix = "${local.name_prefix}-asgG7" 
  min_size             = var.minisize
  desired_capacity     = var.desiredcapacity
  max_size             = var.maxsize
  
  health_check_type    = "ELB"
  load_balancers = [
    "${aws_elb.web_elb.id}"
  ]
  
  target_group_arns = [var.target_group_arn]
  
  launch_configuration = var.launch-configuration

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier  = var.private_subnet

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
      key  = "Name" 
      value ="${local.name_prefix}-Amazon-VM"
      propagate_at_launch = true
    }
  }  