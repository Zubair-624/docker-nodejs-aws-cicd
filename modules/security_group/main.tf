# resource "aws_security_group" "main" {
    
#     tags = {
#         Name = "${var.project_name}-sg"
#     }

#     description = "Allow SSH and HTTP access for EC2"

#     vpc_id = var.main_vpc_id
  
# }

# # Inbound Rule -> SSH
# resource "aws_vpc_security_group_ingress_rule" "ssh" {

#     security_group_id = aws_security_group.main.id
#     description = "Allow SSH from my IP range"

#     from_port = 22
#     to_port = 22
#     ip_protocol = "tcp"
#     cidr_ipv4 = var.allowed_ssh_cidr
  
# }

# # Inbound Rule -> HTTP
# resource "aws_vpc_security_group_ingress_rule" "http" {

#     security_group_id = aws_security_group.main.id
#     description = "Allow HTTP from anywhere"

#     from_port = 80
#     to_port = 80
#     ip_protocol = "tcp"
#     cidr_ipv4 = "0.0.0.0/0"
  
# }

# #Inbound Rule -> Node.js
# resource "aws_vpc_security_group_ingress_rule" "nodejs" {

#     security_group_id = aws_security_group.main.id
#     description = "Allow Node.js app access from anywhere"

#     from_port = 3000
#     to_port = 3000
#     ip_protocol = "tcp"
#     cidr_ipv4 = "0.0.0.0/0"
  
# }

# # Outbound Rule -> Allow All
# resource "aws_vpc_security_group_egress_rule" "all" {

#     security_group_id = aws_security_group.main.id
#     description = "Allow all outbound traffic"

#     ip_protocol = "-1"
#     cidr_ipv4 = "0.0.0.0/0"
  
# }

# #─────────────────────────────────────────

# resource "aws_security_group" "bastion_sg" {

#     tags = {
#         Name = "${var.project_name}-bastion-sg"
#     }

#     description = "Allow SSH access form my laptop"

#     vpc_id = var.main_vpc_id

  
# }

# resource "aws_vpc_security_group_ingress_rule" "ssh" {

#     security_group_id = aws_security_group.main.id
#     description = "Allow SSH from my IP range"

#     from_port = 22
#     to_port = 22
#     ip_protocol = "tcp"
#     cidr_ipv4 = var.allowed_ssh_cidr
  
# }


#----------Bastion Security Group----------
# Only accepts SSH from anywhere (protected by .pem key)
# This is the ONLY entry point to the private network
resource "aws_security_group" "bastion_sg" {

    tags = {
        Name = "${var.project_name}-bastion-sg"
    }

    description = "Bastion host SG - SSH entry point to private network"

    vpc_id = var.main_vpc_id
  
}

# Inbound SSH → open to everyone
# Security comes from .pem key not IP restriction
# This fixes the IP change problem forever
resource "aws_vpc_security_group_ingress_rule" "bastion_ssh" {

    security_group_id = aws_security_group.bastion_sg.id
    description = "Allow SSH from anywhere - protected by .pem key"

    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = var.allowed_ssh_cidr

}

# Outbound → allow all
# Bastion needs to SSH into app server
resource "aws_vpc_security_group_egress_rule" "bastion_all" {

    security_group_id = aws_security_group.bastion_sg.id
    description = "Allow all outbound traffic from bastion"

    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"

}


#----------App Server Security Group----------
# Port 22 only from bastion SG - NOT from internet
# Port 80 and 3000 open to everyone
resource "aws_security_group" "app_sg" {

    tags = {
        Name = "${var.project_name}-app-sg"
    }

    description = "App server SG - SSH only from bastion"

    vpc_id = var.main_vpc_id
  
}

# Inbound SSH → ONLY from bastion security group
# referenced_security_group_id = only EC2s with bastion SG can SSH here
# This is more secure than IP based rules
resource "aws_vpc_security_group_ingress_rule" "app_ssh" {

    security_group_id = aws_security_group.app_sg.id
    description = "Allow SSH only from bastion security group"

    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    referenced_security_group_id = aws_security_group.bastion_sg.id
  
}

# Inbound HTTP → open to everyone
resource "aws_vpc_security_group_ingress_rule" "app_http" {

    security_group_id = aws_security_group.app_sg.id
    description = "Allow HTTP from anywhere"

    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
  
}

# Inbound Node.js → open to everyone
resource "aws_vpc_security_group_ingress_rule" "app_nodejs" {

    security_group_id = aws_security_group.app_sg.id 
    description = "Allow Node.js app access from anywhere"

    from_port = 3000
    to_port = 3000
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
  
}

# Outbound → allow all
# App server needs to pull Docker images via NAT Gateway
resource "aws_vpc_security_group_egress_rule" "app_all" {

    security_group_id = aws_security_group.app_sg.id 
    description = "Allow all outbound - needed for Docker pull via NAT"

    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
  
}