#----------VPC----------
output "main_vpc_id" {
    description = "ID of the VPC"
    value       = module.vpc.main_vpc_id
}

#----------Bastion----------
# SSH into this IP from your laptop
# Use this as BASTION_PUBLIC_IP in GitHub Secrets
output "bastion_public_ip" {
    description = "Bastion Elastic IP — SSH entry point from laptop"
    value       = module.bastion.bastion_public_ip
}

# Bastion instance ID
output "bastion_instance_id" {
    description = "Bastion EC2 instance ID"
    value       = module.bastion.bastion_instance_id
}

#----------App Server----------
# EC2 instance ID
output "app_instance_id" {
    description = "App server EC2 instance ID"
    value       = module.ec2.aws_instance_ids
}

# Use this to SSH from bastion: ssh ubuntu@APP_PRIVATE_IP
# Use this as APP_PRIVATE_IP in GitHub Secrets
output "app_private_ip" {
    description = "App server private IP — SSH from bastion using this"
    value       = module.ec2.private_ip
}

# Public DNS
output "app_public_dns" {
    description = "App server public DNS"
    value       = module.ec2.public_dns
}