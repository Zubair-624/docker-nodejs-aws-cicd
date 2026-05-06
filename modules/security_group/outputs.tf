#----------This security_group_ids will be used in the modules/ec2/main.tf
output "security_group_ids" {

    description = "ID of the security group - used by ec2 module"
    value = aws_security_group.main.id 
  
}