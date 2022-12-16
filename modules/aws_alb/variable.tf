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
  type        = string
  default     = "group7"
  description = "Name prefix"
}

# Provision public subnets in custom VPC
variable "public_subnets" {
  default     = []
  type        = list(string)
  description = "Public Subnet CIDRs"
}

#Provision of Private Subnet
variable "private_subnets" {
  default     = []
  description = "Private Subnet CIDRs"

}
#Security_Group for lad balancer
variable "security_group_lb" {
  default     = []
  type        = list(string)
  description = "Security Group for Load balancer"
}

/*# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
} */

# Terget Group 
variable "target_group_g7" {
  type        = string
  description = "Target Group ARN for loadbalancer"
}
#Specifying Group Name
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}
