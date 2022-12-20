# Default tags
variable "default_tags" {
  default = {}
    #"Owner" = "Prashant|Prince|Subham",
    #"App"   = "WebServer"
    #"StudentIds" = "171162217|1897384|23495"
  

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
#Security_Group for load balancer
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
variable "target_group" {
  type        = string
  description = "Target Group ARN for loadbalancer"
}
#Specifying Group Name
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}

# Get the VPC ID for the Traget Group
variable "vpc_id" {
  type        = string
  description = "VPC ID"
}