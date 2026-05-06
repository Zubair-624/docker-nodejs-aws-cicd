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

#----------IP Range----------
variable "ssh_cidr" {

    description = "My IP range allowed for SSH access"
    type = string
    default = "180.94.28.0/24"
  
}




