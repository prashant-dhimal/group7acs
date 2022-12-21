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
  default     = []
  type        = list(string)
  description = "Public Subnet CIDRs"
}

variable "private_cidr_blocks" {
  default     = []
  type        = list(string)
  description = "Private Subnet CIDRs"
}
# VPC CIDR range
variable "vpc_cidr" {
 # default     = "10.2.0.0/16"
  type        = string
  description = "VPC to host static web site"
}

# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}
