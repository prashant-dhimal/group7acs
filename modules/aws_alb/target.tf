### Module to Create a AWS Load Balancer and a target group

# Target Group 
resource "aws_lb_target_group" "target_group_7" {
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
   tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-TargetGroupG7"
    }
  )
  
} 