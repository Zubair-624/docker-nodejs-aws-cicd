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
resource "aws_internet_gateway" "main" {

    tags = {
        Name = "${var.project_name}-igw"
    }

    vpc_id = aws_vpc.main.id
  
}

#----------Subnet (Public Subent)----------
resource "aws_subnet" "main" {

    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.project_name}-public-subnet-1"
    }

    availability_zone = var.az

    ipv6_cidr_block = var.public_subnet_one_cidr
    
    map_public_ip_on_launch = true 


}

#----------Route Table (Public Route Table)----------
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

#----------Route Table Association (Public Route Table + Public Subnet)
resource "aws_route_table_association" "public" {

    route_table_id = aws_route_table.public.id

    subnet_id = aws_subnet.main.id
  
}