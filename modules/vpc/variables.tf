#----------AWS CIDR Block (10.0.0.0/16)----------
variable "cidr_block" {

    description = "CIDR Block for the AWS VPC"
    type = string
    default = "10.0.0.0/16"
  
}

#----------Availability Zone For Public Subnet (Public Subnet 1)----------
variable "az" {

    description = "AZ for the public subnet"
    type = string
    default = "us-east-1a"
  
}

#----------PUblic Subent CIDR (Public Subnet 1)
variable "public_subnet_one_cidr" {
    
    description = "CIDR block for the public subnet 1"
    type = string
    default = "10.0.1.0/24"
  
}
#----------Project Name----------
variable "project_name" {

    description = "Project name used for naming all resources"
    type = string
  
}

