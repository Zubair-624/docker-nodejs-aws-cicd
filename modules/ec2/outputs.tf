#aws ami(os image-ubuntu)
output "aws_ami_ids" {

    description = "AMI ID used for the EC2 instance"
    value = data.aws_ami.ubuntu_24_04.id
  
}

#aws instance type(t2.micro)
output "aws_instance_ids" {

    description = "ID of the EC2 instance"
    value = aws_instance.main.id

}

#Auto-assign public IP(Enable)
output "public_ip" {

    description = "Public IP of the EC2 instance"
    value = aws_instance.main.public_ip
  
}

# Public DNS of the EC2 instance (use this to access the app in browser)
output "public_dns" {

    description = "Public DNS of the EC2 instance"
    value = aws_instance.main.public_dns
  
}


