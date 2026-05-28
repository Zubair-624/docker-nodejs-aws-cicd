#----------Project Name----------
variable "project_name" {

    description = "Project name used for naming all resources"
    type = string
  
}

#----------VPC CIDR----------
# 10.0.0.0/16 = 65,536 IP addresses inside this VPC
# Referenced in: terraform/environments/dev/main.tf 
variable "aws_vpc_cidr_block" {

    description = "CIDR Block for the AWS VPC"
    type = string
    default = "10.0.0.0/16"
  
}

#----------Availability Zone----------
# AZ for both public subnet and private subnet
# No default - environments/dev/main.tf must pass this explicitly
variable "az" {

    description = "AZ for the public subnet"
    type = string
  
}

#----------AWS Region----------
variable "aws_region" {

    description = "AWS region - used for SSM vpc endpoint service names"
    type = string
    default = "us-east-1"
  
}

#----------SSM Endpoint Security Group ID - ssm_endpoint_sg_id----------
# Security group attached to SSM VPC interface endpoints
# Must allow port 443 inbound from VPC CIDR (10.0.0.0/16)
variable "ssm_endpoint_sg_id" {

    description = "security group id for SSM vpc interface endpoints(allows port 443 inbound from vpc CIDR)"
    type = string
  
}

#----------Public Subnet CIDR - public_subnet_one_cidr----------
# NAT Gateway lives here - access via SSM, no bastion
# 10.0.1.0/24 = 256 IP addresses
# Must be inside VPC CIDR (10.0.0.0/16)
# Referenced in: terraform/environments/dev/main.tf
variable "public_subnet_one_cidr" {
    
    description = "CIDR block for the public subnet 1"
    type = string
    default = "10.0.1.0/24"
  
}

#----------Private Subnet CIDR----------
# App server lives here — no direct internet access
# 10.0.2.0/24 = 256 IP addresses
# Must be inside VPC CIDR (10.0.0.0/16)
# Different range from public subnet (10.0.1.0/24)
variable "private_subnet_one_cidr" {

    description = "CIDR block for the private subnet 1"
    type = string
    default = "10.0.2.0/24"
  
}


