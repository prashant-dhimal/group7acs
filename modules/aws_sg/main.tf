 #Module to Create a Security Group for LoadBalancer

resource "aws_security_group" "security_group_lb_g7" {
  count       = var.type == "LB" ? 1 : 0
  vpc_id      = var.vpc_id
  description = "Security Group for loadbalancer"
  # Ingress rule for allowing connection 
  ingress {
    description = "HTTP access from specific cidrs"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }
  # Egress rule for outgoing
  egress{
      egress {
    description = "Internet access to specific cidrs"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
   }
   tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-SecurityGroup_LB"
    }
  )
}
  }
 ## Security_Group for Ec2 Instance for SSH and HTTP 
 resource "aws_security_group" "security_group_ec2_g7"
 count       = var.type == "EC2" ? 1 : 0
  vpc_id      = var.vpc_id
  description = "Security Group for Ec2 Instance"
   # Ingress rule for allowing connection 
 ## HTTP
  ingress {
    description = "HTTP access from specific cidrs"
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }
 ## SSH Connection
  ingress {
    description = "SSH access from specific cidrs"
    from_port   = 22  
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }
  # Egress rule for outgoing connection
  egress{
      egress {
    description = "Internet access to specific cidr"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr
   }
   tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-SecurityGroup_EC2"
    }
  )
}
  }
  
   ## Security_Group for Bastion HostI for SSH and HTTP 
 resource "aws_security_group" "security_group_bastion_g7"
 count       = var.type == "Bastion" ? 1 : 0
  vpc_id      = var.vpc_id
  description = "Security Group for Bastion Host"
   # Ingress rule for allowing connection 
 # SSH Connection
  ingress {
    description = "SSH access from specific cidrs"
    from_port   = 22  
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }
  # Egress rule for outgoing connection
  egress{
      egress {
    description = "Internet access to specific cidr"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr
   }
   tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-SecurityGroup_BastionHost"
    }
  )
}
  }
  
  
  