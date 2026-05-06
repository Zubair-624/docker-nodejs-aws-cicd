#----------Project Name----------
variable "project_name" {

    description = "Project name used for naming all resources"
    type = string
    default     = "docker-nodejs-aws-cicd"
  
}

#----------VPC----------

#AWS CIDR
variable "cidr_block" {

    description = "CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
  
}

#Public Subnet 
variable "public_subnet_cidr_one" {

    description = "CIDR block for the public subnet"
    type = string
    default = "10.0.1.0/24"
  
}

#AZ
variable "az" {

    description = "Availability zone for the public subnet"
    type = string
    default = "us-east-1a"
  
}


#----------Security Group----------
variable "ssh_cidr" {

    description = "My IP range allowed for SSH access"
    type = string
    default = "180.94.28.0/24"
  
}

#----------EC2 Instance----------

#Instance
variable "instance_type" {

    description = "EC2 Instance Type"
    type = string
    default = "t2.micro"

}

#Key Name
variable "key_name" {

    description = "AWS Key Pair name for SSH access"
    type = string
    default = "devops-zubair-terminal-key"
  
}

#----------S3 Bucket----------
variable "s3_bucket_name" {

    description = "S3 bucket name for IAM policy - already exists"
    type = string
    default = "devops-zubair-terraform-state"
  
}
