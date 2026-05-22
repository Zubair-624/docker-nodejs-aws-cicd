#----------Project Name----------
variable "project_name" {
    description = "Project name used for naming all resources"
    type = string
}

#----------main_vpc_id comes from modules/vpc/outputs.tf----------
variable "main_vpc_id" {

    description = "ID of the VPC - comes from vpc module output"
    type = string
  
}

# Applied to BASTION only - not app server
# 0.0.0.0/0 = open to everyone
# Security comes from .pem key - fixes IP change problem forever
variable "allowed_ssh_cidr" {

    description = "IP range allowed for SSH to bastion"
    type = string
    default = "0.0.0.0/0"
  
}




