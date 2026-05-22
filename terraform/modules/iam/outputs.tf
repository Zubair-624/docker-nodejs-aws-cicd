# IAM instance profile name → used by modules/ec2/main.tf
# iam_instance_profile = module.iam.aws_iam_instance_profile_name
output "aws_iam_instance_profile_name" {
    description = "IAM instance profile name - used by ec2 module"
    value       = aws_iam_instance_profile.ec2_profile.name
}

# IAM role name → used for attaching additional policies in future
# example: SSM policy attachment in future projects
output "iam_role_name" {
    description = "IAM role name - used for attaching additional policies"
    value       = aws_iam_role.ec2_role.name
}