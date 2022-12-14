#Creating Resource for AUtoScaling
resource "aws_autoscaling_policy" "web_scaling_policy_up" {
  name = "${local.name_prefix}-ASG-G7-Web-UP"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 30
  autoscaling_group_name = aws_autoscaling_group.webserver_group_7.name
}
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name = "${local.name_prefix}-ASG-Web-Cpu-Alarm-Up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = var.threshold_scale_up
dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.webserver_group_7.name}"
  }
alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions =  ["${aws_autoscaling_policy.web_scaling_policy_up.arn}"] 
}
resource "aws_autoscaling_policy" "web_scaling_policy_down" {
  name = "${local.name_prefix}-ASG-Web-Down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 30
  autoscaling_group_name = aws_autoscaling_group.webserver_group_7.name
}
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name = "${local.name_prefix}-ASG-Web-Alarm-Down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "180"
  statistic = "Average"
  threshold = var.threshold_scale_down
dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.webserver_group_7.name}"
  }
alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = ["${aws_autoscaling_policy.web_scaling_policy_down.arn}"] 
}