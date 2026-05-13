# Bastion Elastic IP — permanent, never changes
# Use this to SSH from your laptop: ssh -i key.pem ubuntu@BASTION_EIP
# Use this as BASTION_PUBLIC_IP in GitHub Secrets
output "bastion_public_ip" {
    description = "Permanent Elastic IP of bastion — SSH entry point from laptop"
    value       = aws_eip.bastion.public_ip
}

# Bastion instance ID
output "bastion_instance_id" {
    description = "Bastion EC2 instance ID"
    value       = aws_instance.bastion.id
}

# Bastion private IP — internal IP inside VPC
# Not used for SSH from laptop
# Only used for internal VPC communication
output "bastion_private_ip" {
    description = "Private IP of bastion inside VPC"
    value       = aws_instance.bastion.private_ip
}