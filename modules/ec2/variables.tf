#----------Project Name----------
variable "project_name" {

    description = "Project name used for naming all resources"
    type = string
  
}

#----------EC2 Instance Type (t2.micro, t3.micro, t3.medium)----------
variable "instance_type" {

    description = "EC2 instance type"
    type = string
    default = "t2.micro"
  
}

#----------Key Pair/Name(login)----------
variable "key_name" {

    description = "AWS Key Pair name for SSH access"
    type = string
    default = "devops-zubair-terminal-key"
  
}

#Public Subnet Id(public_subnet_ids) this comes from the modules/vpc/outputs.tf
variable "public_subnet_ids" {

    description = "ID of the public subnet - comes from vpc module output"
    type = string
  
}

#Security Group ID(security_group_ids) this comes from the modules/security_group/outputs.tf 
variable "security_group_ids" {

    description = "ID of the security group - comes from security-group module output"
    type = string
  
}

#----------Vloume Size(Configure Storage)----------
variable "volume_size" {

    description = "Root volume size in GB"
    type = number
    default = 8
  
}

#----------IAM instance profile----------
variable "iam_instance_profile" {

    description = "IAM instance profile name to attach to EC2"
    type = string
    default = null

}