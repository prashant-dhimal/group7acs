# VPC CIDR range
variable "vpc_cidr" {
  default     = "10.100.0.0/16"
  type        = string
  description = "VPC to host the environment"
}

# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}


# Instance Profile Name for the LaunchConfig 
variable "iam_instance_profile_name" {
  default     = "EC2BUCKETACCESS"
  type        = string
  description = "Instance Profile Name for the LaunchConfig. It  needs to be created and updated in case this is not present"
}

# Instance type fir the LaunchConfig based on environment
variable "instance_type" {
  default = {
    "prod"    = "t3.medium"
    "staging" = "t3.small"
    "dev"     = "t3.micro"
  }
  description = "Type of the instance"
  type        = map(string)
}

# Minimum Size for the auto scaling group based on environment
variable "minsize" {
  default = {
    "prod"    = "1"
    "staging" = "1"
    "dev"     = "1"
  }
  description = "Minimum Size for the auto scaling group"
  type        = map(string)
}

# MMaximum Size for the auto scaling group based on environment
variable "desiredcapacity" {
  default = {
    "prod"    = "3"
    "staging" = "3"
    "dev"     = "2"
  }
  description = "Desired Capaicty for the auto scaling group"
  type        = map(string)
}

# Maximum Size for the auto scaling group based on environment
variable "maxsize" {
  default = {
    "prod"    = "4"
    "staging" = "4"
    "dev"     = "4"
  }
  description = "Maximum Size for the auto scaling group"
  type        = map(string)
}