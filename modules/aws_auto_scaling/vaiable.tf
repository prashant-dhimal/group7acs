variable "default_tags" {
  default = {}
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix
variable "prefix" {
  type        = string
  description = "Name prefix"
}

#Assigning Minumum size of Instances
variable "minisize" {
    type        = string
    description = "Mini Size of No. of Instances"
}

# Assigning Maximum size of Instances
variable "maxsize" {
   type         = string    
   description  = "Max size of No. of Instances"
}

# Assigning  Desired Capacity of Instances
variable "desiredcapacity" {
    type        = string
    description = "Desired capacity of No. of Instances"
}   

# Assigning Target Group
variable "target_group_arn" {
  type        = string
  description = "Target Group ARN for the ASG"
}

# Private subnet IDs  required by the ASG
variable "private_subnet" {
  default     = []
  type        = list(string)
  description = "Private Subnet"
}

# LaunchConfig name for the ASG
variable "launch-configuration" {
  type        = string
  description = "LaunchConfig name for the ASG"
}

# Assigning Threshold for scaling Down
variable "threshold_scale_down" {
  type        = string
  description = "scale_dwon threshold for the ASG policy"
}

# Assigning Threshold for Scaling up
variable "threshold_scale_up" {
  type        = string
  description = "scale_up threshold for the ASG policy"
}

# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}