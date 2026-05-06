resource "aws_security_group" "main" {
    
    tags = {
        Name = "${var.project_name}-sg"
    }

    description = "Allow SSH and HTTP access for EC2"

    vpc_id = var.main_vpc_id
  
}

# Inbound Rule -> SSH
resource "aws_vpc_security_group_ingress_rule" "ssh" {

    security_group_id = aws_security_group.main.id
    description = "Allow SSH from my IP range"

    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = var.ssh_cidr
  
}

# Inbound Rule -> HTTP
resource "aws_vpc_security_group_ingress_rule" "http" {

    security_group_id = aws_security_group.main.id
    description = "Allow HTTP from anywhere"

    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
  
}

#Inbound Rule -> Node.js
resource "aws_vpc_security_group_ingress_rule" "nodejs" {

    security_group_id = aws_security_group.main.id
    description = "Allow Node.js app access from anywhere"

    from_port = 3000
    to_port = 3000
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
  
}

# Outbound Rule -> Allow All
resource "aws_vpc_security_group_egress_rule" "all" {

    security_group_id = aws_security_group.main.id
    description = "Allow all outbound traffic"

    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
  
}