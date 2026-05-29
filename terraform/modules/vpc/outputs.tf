# main_vpc_id -> used by:
# modules/security_group/main.tf (vpc_id)
# main_vpc_id -> used by: modules/security_group, modules/vpc_endpoints
output "main_vpc_id" {

    description = "ID of the VPC"
    value = aws_vpc.vpc.id
  
}

# public_subnet_id -> used by: environments/dev/main.tf (NAT Gateway)
# public_subnet_ids -> used by:
# modules/bastion/main.tf (bastion lives here)
# modules/vpc/main.tf (NAT Gateway lives here)
output "public_subnet_ids" {

    description = "ID of the Public Subnet(Public Subnet 1)"
    value = aws_subnet.public_subnet_one.id
  
}

# private_subnet_id -> used by: modules/ec2, modules/vpc_endpoints
# private_subnet_ids -> used by:
# modules/ec2/main.tf (app server lives here)
output "private_subnet_ids" {

    description = "ID of the Private Subnet (Private Subnet 1)"
    value = aws_subnet.private_subnet_one.id
  
}

# private_rt_id -> used by: modules/vpc_endpoints (S3 gateway endpoint)
output "private_rt_id" {

    description = "Private route table ID - used by vpc_endpoints module for S3 gateway endpoint"
    value = aws_route_table.private.id 
  
}