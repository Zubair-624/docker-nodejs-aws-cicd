# AMI ID used for the EC2 instance
output "aws_ami_ids" {
    description = "AMI ID used for the EC2 instance"
    value       = data.aws_ami.ubuntu_24_04.id
}

# EC2 instance ID
output "aws_instance_ids" {
    description = "ID of the EC2 instance"
    value       = aws_instance.main.id
}

# Private IP of app server
# Use this to SSH from bastion: ssh ubuntu@PRIVATE_IP
# Use this as APP_PRIVATE_IP in GitHub Secrets
output "private_ip" {
    description = "Private IP of app server — SSH from bastion using this"
    value       = aws_instance.main.private_ip
}

# Public DNS — even though app server is private
# this will be empty since no public IP assigned
output "public_dns" {
    description = "Public DNS of the EC2 instance"
    value       = aws_instance.main.public_dns
}