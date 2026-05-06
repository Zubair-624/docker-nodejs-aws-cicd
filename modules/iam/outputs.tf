output "aws_iam_instance_profile_name" {

    description = "IAM instance profile name - used by ec2 module"
    value       = aws_iam_instance_profile.ec2_profile.name
  
}