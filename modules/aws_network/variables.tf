# Default tags
variable "default_tags" {
  default     = {}
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix
variable "prefix" {
  type        = string
  default     = "Group7"
  description = "Name prefix"
}

# Provision public subnets in custom VPC
variable "public_cidr_blocks" {
  default     = ["10.2.0.0/24", "10.2.1.0/24", "10.2.2.0/24"]
  type        = list(string)
  description = "Public Subnet CIDRs"
}

variable "private_cidr_blocks" {
  default     = ["10.2.3.0/24", "10.2.4.0/24", "10.2.5.0/24"]
  type        = list(string)
  description = "Private Subnet CIDRs"
}
# VPC CIDR range
variable "vpc_cidr" {
  default     = "10.2.0.0/16"
  type        = string
  description = "VPC to host static web site"
}

# Variable to signal the current environment 
variable "env" {
  default     = "ACSFINAL"
  type        = string
  description = "Deployment Environment"
}

