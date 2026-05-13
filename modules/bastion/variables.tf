#----------Project Name----------
variable "project_name" {
    description = "Project name used for naming all resources"
    type        = string
}

#----------Instance Type----------
# t2.micro = free tier eligible
# bastion only forwards SSH — needs very low resources
variable "instance_type" {
    description = "Bastion EC2 instance type"
    type        = string
    default     = "t2.micro"
}

#----------Key Name----------
# Reusable SSH key from devops-zubair-key repo
# Never recreate — already exists in AWS
variable "key_name" {
    description = "AWS Key Pair name for SSH access"
    type        = string
    default     = "devops-zubair-terminal-key"
}

#----------Public Subnet ID----------
# Bastion lives in public subnet
# comes from modules/vpc/outputs.tf → public_subnet_ids
variable "public_subnet_id" {
    description = "Public subnet ID — bastion lives here"
    type        = string
}

#----------Bastion Security Group ID----------
# comes from modules/security_group/outputs.tf → bastion_sg_id
variable "bastion_sg_id" {
    description = "Bastion security group ID — comes from security_group module"
    type        = string
}