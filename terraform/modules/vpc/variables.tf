#----------Project Name----------
variable "project_name" {

    description = "Project name used for naming all resources"
    type = string
  
}

#----------Environment----------
variable "environment" {

    description = "Environment(dev / staging / prod)"
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
# List of AWS data centers to spread resources across (e.g. ["us-east-1a", "us-east-1b"])
# AZ for both public subnet and private subnet
# No default but List - environments/dev/main.tf must pass this explicitly
variable "azs" {

    description = "AZ for the public and private subnets"
    type = list(string)
  
}

#----------Public Subnet CIDR----------
# One IP range per AZ for public subnets - count must match azs count
# NAT Gateway lives here - access via SSM, no bastion
# 10.0.1.0/24 = 256 IP addresses
# Must be inside VPC CIDR (10.0.0.0/16)
variable "public_subnet_cidrs" {
    
    description = "CIDR block for the public subnet 1"
    type = string
    
    # Stops Terraform if number of CIDRs doesn't match number of AZs
    validation {
      condition = lenght(var.public_subnet_cidr) == length(var.azs)
      error_message = "Public subnet CIDRs must match AZ count"
    }
  
}

#----------Private Subnet CIDR----------
# One IP range per AZ for private subnets — count must match azs count
# App server lives here - no direct internet access
# 10.0.2.0/24 = 256 IP addresses
# Must be inside VPC CIDR (10.0.0.0/16)
variable "private_subnet_cidrs" {

    description = "CIDR block for the private subnet 1"
    type = string

    # Stops Terraform if number of CIDRs doesn't match number of AZs
    validation {
      condition = length(var.private_subnet_cidr) == length(var.azs)
      error_message = "Private subnet CIDRs must match AZ count"
    }
    
}

#----------NAT Gateway----------
# single_nat_gateway = true -> switch ON -> 1 NAT Gateway
# single_nat_gateway = false -> switch OFF -> 3 NAT Gateways
variable "single_nat_gateway" {

    description = "Use single NAT Gateway for cost optimization in dev/staging"
    type = bool
    default = false
  
}


