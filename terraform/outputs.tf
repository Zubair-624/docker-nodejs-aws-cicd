#----------VPC----------
output "main_vpc_ids" {

    description = "ID of the VPC"
    value = module.vpc.main_vpc_id
  
}

#----------EC2----------

#aws instance type(t2.micro)
output "aws_instance_ids" {

    description = "ID of the EC2"
    value = module.ec2.aws_instance_ids
  
}

#Auto-assign public IP(Enable)
output "public_ip" {

    description = "Public IP of the EC2 instance"
    value = module.ec2.public_ip
  
}

# Public DNS of the EC2 instance (use this to access the app in browser)
output "public_dns" {

    description = "Public DNS of the EC2 instance"
    value = module.ec2.public_dns
  
}