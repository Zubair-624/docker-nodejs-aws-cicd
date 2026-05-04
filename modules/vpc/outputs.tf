#This main_vpc_id will be used in the -> Security Group (modules/security_group/main.tf)
output "main_vpc_id" {

    description = "ID of the VPC"
    value = aws_vpc.main.id
  
}

#This public_subnet_ids will be used in the -> EC2 Instance (modules/ec2/main.tf)
output "public_subnet_ids" {

    description = "ID of the Public Subnet(Public Subnet 1)"
    value = aws_subnet.main.id
  
}