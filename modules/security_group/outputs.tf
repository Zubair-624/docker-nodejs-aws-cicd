# bastion_sg_ids → used by modules/bastion/main.tf
output "bastion_sg_ids" {

    description = "Bastion security group ID - used by bastion module"
    value = aws_security_group.bastion_sg.id
  
}

# app_sg_ids → used by modules/ec2/main.tf
output "app_sg_ids" {

    description = "App server security group ID - used by ec2 module"
    value = aws_security_group.app_sg.id
  
}