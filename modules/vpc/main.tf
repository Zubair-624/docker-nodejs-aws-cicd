#----------VPC----------
resource "aws_vpc" "vpc" {

    tags = {
        Name = "${var.project_name}-vpc"
    }

    cidr_block = var.aws_vpc_cidr_block

    #-----Allows domain name resolution inside the VPC (e.g. rds.amazonaws.com --> private IP)-----
    # Enables DNS resolution inside the VPC.
    # Without this, instances cannot resolve AWS service domain names.
    # Example:
    #   your EC2 tries to connect to RDS using:
    #   mydb.xxxxxx.us-east-1.rds.amazonaws.com
    #   --> if false, this domain will NOT resolve (connection fails)
    #   --> if true,  this domain resolves to a private IP (works!)
    enable_dns_support = true

    # Gives each EC2 instance a public DNS hostname automatically.
    # Without this, EC2 instances get an IP but NO hostname.
    # Example:
    #   Your EC2 public IP is 52.86.29.38
    #   --> if false, you only get:  52.86.29.38  (IP only)
    #   --> if true,  you also get:  ec2-52-86-29-38.compute-1.amazonaws.com
    enable_dns_hostnames = true 
  
}

#----------IGW----------
# Internet Gateway = door between VPC and public internet
resource "aws_internet_gateway" "igw" {

    tags = {
        Name = "${var.project_name}-igw"
    }

    vpc_id = aws_vpc.vpc.id
  
}

#----------Public Subnet----------
# Bastion host + NAT Gateway live here
resource "aws_subnet" "public_subnet_one" {

    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-public-subnet-1"
    }

    availability_zone = var.az

    cidr_block = var.public_subnet_one_cidr
    
    map_public_ip_on_launch = true 

}

#----------Private Subnet----------
# App server lives here - no direct internet access
# More secure - not reachable from internet directly

resource "aws_subnet" "private_subnet_one" {

    vpc_id = aws_vpc.vpc.id

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

    subnet_id = aws_subnet.public_subnet_one.id

    connectivity_type = "public" 

    allocation_id = aws_eip.eip_nat.id

    # depends_on = IGW must exist before NAT Gateway can route traffic to internet
    # IGW has no direct reference in this resource so must declare manually
    depends_on = [ aws_internet_gateway.igw ]
  
}
#──────────────────────────────────────────────────────────────────────────────────

#──────────────────────────────────────────────────────────────────────────────────
#----------Public Route Table----------
# PUBLIC Route Table
#   → Used by PUBLIC subnets
#  → Rule: "all internet traffic → go through Internet Gateway"
#   → ONE route table shared by all public subnets
# Route Table = A set of rules that tells network traffic WHERE to go
# Route Table  =  Road signs in a city
# Routes       =  Individual signs ("To Airport → Turn Left")

# Without road signs → cars get lost, traffic goes nowhere
# With road signs    → traffic knows exactly where to go

# All public subnets use the SAME Internet Gateway
# → Only ONE IGW exists per VPC
# → So ONE route table is enough for all public subnets

#    public-subnet-1 ──┐
#    public-subnet-2 ──┼──→ same route table → Internet Gateway
#    public-subnet-3 ──┘

# Routes all internet traffic through IGW
# Used by public subnet (bastion + NAT Gateway)
resource "aws_route_table" "public" {
  
    tags = {
        Name = "${var.project_name}-public-rt"
    }

    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

}

#----------Route Table Association (Public Route Table + Public Subnet)----------
# Connects public route table to public subnet
resource "aws_route_table_association" "public" {

    route_table_id = aws_route_table.public.id

    subnet_id = aws_subnet.public_subnet_one.id 
  
}
#──────────────────────────────────────────────────────────────────────────────────

#──────────────────────────────────────────────────────────────────────────────────
#----------Private Route Table----------
# PRIVATE Route Tables
#   → Used by PRIVATE subnets
#   → Rule: "all internet traffic → go through NAT Gateway"
#   → ONE route table PER AZ (because each AZ has its own NAT Gateway)

# Each private subnet uses a DIFFERENT NAT Gateway
# → One NAT Gateway per AZ
# → So each AZ needs its OWN route table

#    private-subnet-1 ──→ route table 1 → NAT Gateway 1 (us-east-1a)
#    private-subnet-2 ──→ route table 2 → NAT Gateway 2 (us-east-1b)
#    private-subnet-3 ──→ route table 3 → NAT Gateway 3 (us-east-1c)

# Routes all internet traffic through NAT Gateway
# Used by private subnet (app server)
# Outbound only — nobody from internet can reach private subnet

resource "aws_route_table" "private" {

    tags = {
        Name = "${var.project_name}-private-rt"
    }

    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
  
}

#----------Route Table Association (Private Route Table + Private Subnet)----------
# Connects private route table to private subnet

resource "aws_route_table_association" "private" {

    route_table_id = aws_route_table.private.id

    subnet_id = aws_subnet.private_subnet_one.id 

}
#──────────────────────────────────────────────────────────────────────────────────