# # IAM instance profile name → used by modules/ec2/main.tf
# # iam_instance_profile = module.iam.aws_iam_instance_profile_name
# output "aws_iam_instance_profile_name" {
#     description = "IAM instance profile name - used by ec2 module"
#     value       = aws_iam_instance_profile.ec2_profile.name
# }

# # IAM role name → used for attaching additional policies in future
# # example: SSM policy attachment in future projects
# output "iam_role_name" {
#     description = "IAM role name - used for attaching additional policies"
#     value       = aws_iam_role.ec2_role.name
# }

#==================================================================================
# this output into my EC2 resource
# ec2 resource → iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name
output "ssm_instance_profile_name" {

    description = "Attach this to my EC2 instance resource"
    value = aws_iam_instance_profile.ssm_profile.name
  
}

output "ssm_role_arn" {

    description = "ARN of the IAM role"
    value = aws_iam_role.ssm_role.arn
  
}
#==================================================================================