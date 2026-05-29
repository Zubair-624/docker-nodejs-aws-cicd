#----------Project Name----------
variable "project_name" {

    description = "Project name used for naming all resources"
    type = string
  
}

#----------VPC CIDR----------
# 10.0.0.0/16 = 65,536 IP addresses inside this VPC 
variable "aws_vpc_cidr_block" {

    description = "CIDR Block for the AWS VPC"
    type = string
    default = "10.0.0.0/16"
  
}

#----------Availability Zone----------
# AZ for both public subnet and private subnet
# No default but List - environments/dev/main.tf must pass this explicitly
variable "azs" {

    description = "AZ for the public and private subnets"
    type = list(string)
  
}

#----------Public Subnet CIDR - public_subnet_one_cidr----------
# NAT Gateway lives here - access via SSM, no bastion
# 10.0.1.0/24 = 256 IP addresses
# Must be inside VPC CIDR (10.0.0.0/16)
variable "public_subnet_one_cidr" {
    
    description = "CIDR block for the public subnet 1"
    type = string
    default = "10.0.1.0/24"
  
}

#----------Private Subnet CIDR----------
# App server lives here - no direct internet access
# 10.0.2.0/24 = 256 IP addresses
# Must be inside VPC CIDR (10.0.0.0/16)
variable "private_subnet_one_cidr" {

    description = "CIDR block for the private subnet 1"
    type = string
    default = "10.0.2.0/24"
  
}


