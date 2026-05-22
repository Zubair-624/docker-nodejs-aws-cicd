#----------Project Name----------
variable "project_name" {
    description = "Project name used for naming all resources"
    type        = string
}

#----------EC2 Instance Type----------
variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t2.micro"
}

#----------Key Pair----------
# Reusable key from devops-zubair-key repo — never recreate
variable "key_name" {
    description = "AWS Key Pair name for SSH access"
    type        = string
    default     = "devops-zubair-terminal-key"
}

#----------Private Subnet ID----------
# App server lives in private subnet — not public!
# comes from modules/vpc/outputs.tf → private_subnet_ids
variable "private_subnet_id" {
    description = "ID of the private subnet — app server lives here"
    type        = string
}

#----------Security Group ID----------
# App server SG — SSH only from bastion
# comes from modules/security_group/outputs.tf → app_sg_id
variable "security_group_ids" {
    description = "App server security group ID — comes from security_group module"
    type        = string
}

#----------Volume Size----------
variable "volume_size" {
    description = "Root volume size in GB"
    type        = number
    default     = 8
}

#----------IAM Instance Profile----------
# Allows EC2 to read from S3
# comes from modules/iam/outputs.tf → aws_iam_instance_profile_name
variable "iam_instance_profile" {
    description = "IAM instance profile name to attach to EC2"
    type        = string
    default     = null
}