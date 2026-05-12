#----------VPC----------
resource "aws_vpc" "main" {

    tags = {
        Name = "${var.project_name}-vpc"
    }

    cidr_block = var.cidr_block

    enable_dns_support = true
    enable_dns_hostnames = true 
  
}

#----------IGW----------
# Internet Gateway = door between VPC and public internet
resource "aws_internet_gateway" "main" {

    tags = {
        Name = "${var.project_name}-igw"
    }

    vpc_id = aws_vpc.main.id
  
}

#----------Public Subent----------
# Bastion host + NAT Gateway live here
resource "aws_subnet" "public" {

    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.project_name}-public-subnet-1"
    }

    availability_zone = var.az

    cidr_block = var.public_subnet_one_cidr
    
    map_public_ip_on_launch = true 

}

#----------Private Subnet----------
# App server lives here - no direct internet access
# More secure — not reachable from internet directly

resource "aws_subnet" "private" {

    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.project_name}-private-subnet-1"
    }

    availability_zone = var.az

    cidr_block = var.private_subnet_one_cidr

    map_public_ip_on_launch = false

  
}

#──────────────────────────────────────────────────────────────────────────────────
#----------Elastic IP----------
# Create Elastic IP first (NAT Gateway needs it)
# Elastic IP for NAT Gateway
# NAT Gateway needs a fixed public IP to work

resource "aws_eip" "eip_nat" {

    # Means: "This Elastic IP is for VPC use"
    domain = "vpc"

    tags = {
        Name = "${var.project_name}-eip-for-nat"
    }

}

#----------NAT Gateway----------
# Sits in PUBLIC subnet
# Allows private subnet resources to reach internet (outbound only)
# App server uses this to pull Docker images from Docker Hub
# depends_on = IGW must exist before NAT Gateway
resource "aws_nat_gateway" "nat" {

    tags = {
        Name = "${var.project_name}-nat-gateway"
    }

    subnet_id = aws_subnet.public.id

    connectivity_type = "public" 

    allocation_id = aws_eip.eip_nat.id

    # depends_on = IGW must exist before NAT Gateway can route traffic to internet
    # IGW has no direct reference in this resource so must declare manually
    depends_on = [ aws_internet_gateway.main ]
  
}
#──────────────────────────────────────────────────────────────────────────────────

#──────────────────────────────────────────────────────────────────────────────────
#----------Public Route Table----------
# Routes all internet traffic through IGW
# Used by public subnet (bastion + NAT Gateway)
resource "aws_route_table" "public" {
  
    tags = {
        Name = "${var.project_name}-public-rt"
    }

    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

}

#----------Route Table Association (Public Route Table + Public Subnet)----------
# Connects public route table to public subnet
resource "aws_route_table_association" "public" {

    route_table_id = aws_route_table.public.id

    subnet_id = aws_subnet.public.id
  
}
#──────────────────────────────────────────────────────────────────────────────────

#──────────────────────────────────────────────────────────────────────────────────
#----------Private Route Table----------
# Routes all internet traffic through NAT Gateway
# Used by private subnet (app server)
# Outbound only — nobody from internet can reach private subnet

resource "aws_route_table" "private" {

    tags = {
        Name = "${var.project_name}-private-rt"
    }

    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
  
}

#----------Route Table Association (Private Route Table + Private Subnet)----------
# Connects private route table to private subnet

resource "aws_route_table_association" "private" {

    route_table_id = aws_route_table.private.id

    subnet_id = aws_subnet.private.id 

}
#──────────────────────────────────────────────────────────────────────────────────