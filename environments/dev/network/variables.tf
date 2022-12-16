# Default tags
variable "default_tags" {
  default = {
    "Owner" = "PPS",
    "App"   = "WebServer"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix
variable "prefix" {
  default     = "group7"
  type        = string
  description = "Name prefix"
}

# Provision public subnets in custom VPC
variable "public_subnet_cidrs" {
  default     = ["10.100.0.0/24", "10.100.1.0/24", "10.100.2.0/24"]
  type        = list(string)
  description = "Public Subnet CIDRs"
}
variable "private_subnet_cidrs" {
  default     = ["10.100.3.0/24", "10.100.4.0/24", "10.100.5.0/24"]
  description = "Private Subnet CIDRs"

}
# VPC CIDR range
variable "vpc_cidr" {
  default     = "10.100.0.0/16"
  type        = string
  description = "VPC to host static web site"
}

# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}