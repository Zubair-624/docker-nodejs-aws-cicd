#----------VPC ID Output----------
# main_vpc_id -> used by:
# modules/security_group/main.tf (vpc_id)
# main_vpc_id -> used by: modules/security_group, modules/vpc_endpoints
output "main_aws_vpc_id" {

    description = "ID of the VPC"
    value = aws_vpc.vpc.id
  
}

#----------Public Subnet IDs Output----------
# Will Used by: Load Balancer, Bastion Host, any internet-facing resource
# public_subnet_id -> used by: environments/dev/main.tf (NAT Gateway)
# public_subnet_ids -> used by:
# modules/bastion/main.tf (bastion lives here)
# modules/vpc/main.tf (NAT Gateway lives here)
output "public_subnet_ids" {

    description = "ID of the Public Subnet(Public Subnet 1)"
    value = aws_subnet.public_subnets[*].id
  
}

#----------Private Subnet IDs Output----------
# private_subnet_id -> used by: modules/ec2, modules/vpc_endpoints
# private_subnet_ids -> used by:
# modules/ec2/main.tf (app server lives here)
output "private_subnet_ids" {

    description = "ID of the Private Subnet (Private Subnet 1)"
    value = aws_subnet.private_subnets[*].id
  
}

#----------Nat Gateway IDs Output----------
# Returns all NAT Gateway IDs as a list
# Count depends on -> single_nat_gateway
# true  = returns 1 ID
# false = returns 3 IDs
output "nat_gateways_id" {

    value = aws_nat_gateway.nat_gateways[*].id 
  
}

#----------NAT Gateway Count Output----------
# Returns how many NAT Gateways were actually created
# Useful for monitoring and cost tracking
# dev/staging = 1
# production  = 3
output "nat_gateway_output" {

    description = "Number of NAT Gateways created"
    value = length(aws_nat_gateway.nat_gateways[*].id)
  
}

#----------Public Route Table Output----------
# Returns the single public route table ID
# No [*] needed because only 1 public route table exists
output "public_route_table_id" {

    value = aws_route_table.public_rt.id
  
}


#----------Private Route Tables Output----------
# Returns all private route table IDs as a list
# Always 3 IDs (one per AZ) regardless of single_nat_gateway
# dev/staging = all 3 point to same NAT GW
# production  = each points to own NAT GW
output "private_route_table_id" {

    value = aws_route_table.private_rt[*].id
  

}