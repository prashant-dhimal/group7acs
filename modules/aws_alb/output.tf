#for alb dns name
output "LB_DNS_Name" {
  value = aws_lb.loadbalancer_g7.dns_name
}

# for alb id
output "LB_id" {
  value = aws_lb.loadbalancer_g7.id
}
# output for Target group
output "Target_Group_ARN" {
  value = aws_lb_target_group.target_group_7.arn
}