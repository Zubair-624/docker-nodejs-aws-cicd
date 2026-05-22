#----------Project Name----------
variable "project_name" {
    description = "Project name used for naming all resources"
    type        = string
    default     = "docker-nodejs-aws-cicd"
}

#----------Project Region----------
variable "aws_region" {

    description = "Region of this project"
    type = string
    default = "us-east-1"
  
}


#----------VPC----------

# VPC CIDR
variable "cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

# Public Subnet CIDR — bastion + NAT Gateway live here
variable "public_subnet_cidr_one" {
    description = "CIDR block for the public subnet"
    type        = string
    default     = "10.0.1.0/24"
}

# Private Subnet CIDR — app server lives here
variable "private_subnet_cidr_one" {
    description = "CIDR block for the private subnet"
    type        = string
    default     = "10.0.2.0/24"
}

# Availability Zone
variable "az" {
    description = "Availability zone for the subnets"
    type        = string
    default     = "us-east-1a"
}

#----------Security Group----------
# 0.0.0.0/0 = open to everyone
# Security comes from .pem key — fixes IP change problem forever
variable "ssh_cidr" {
    description = "IP range allowed for SSH to bastion"
    type        = string
    default     = "0.0.0.0/0"
}

#----------EC2----------

# Instance type
variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t2.micro"
}

# Key name — reusable key from devops-zubair-key repo
variable "key_name" {
    description = "AWS Key Pair name for SSH access"
    type        = string
    default     = "devops-zubair-terminal-key"
}

#----------S3----------
# Already exists — do NOT recreate
variable "s3_bucket_name" {
    description = "S3 bucket name for IAM policy - already exists"
    type        = string
    default     = "devops-zubair-terraform-state"
}