# # IAM flow: Instance Profile → IAM Role → IAM Policy
# # Think of it as: Lanyard(Profile) → Badge(Role) → Permissions(Policy)

# #----------IAM Instance Profile----------
# # The connector that attaches an IAM Role to an EC2 instance
# # EC2 cannot use a Role directly — it always needs an Instance Profile
# resource "aws_iam_instance_profile" "ec2_profile" {
#     name = "${var.project_name}-ec2-profile"
#     tags = {
#         Name = "${var.project_name}-ec2-profile"
#     }
#     role = aws_iam_role.ec2_role.name
# }

# #----------IAM Role----------
# # Defines WHO can use this role
# # assume_role_policy = "trust policy" — only EC2 service can assume this role
# # sts:AssumeRole = the action that lets EC2 "put on" this role
# resource "aws_iam_role" "ec2_role" {
#     name = "${var.project_name}-ec2-role"
#     tags = {
#         Name = "${var.project_name}-ec2-role"
#     }
#     assume_role_policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [
#             {
#                 Effect    = "Allow"
#                 Action    = "sts:AssumeRole"
#                 Principal = {
#                     Service = "ec2.amazonaws.com"
#                 }
#             }
#         ]
#     })
# }

# #----------IAM Role Policy----------
# # Defines WHAT the role is allowed to do
# # s3:GetObject  = download/read a file from S3
# # s3:ListBucket = see what files exist in the bucket
# # Resource      = which specific S3 bucket this applies to
# # arn:aws:s3:::bucket-name   = the bucket itself
# # arn:aws:s3:::bucket-name/* = all files inside the bucket
# resource "aws_iam_role_policy" "ec2_policy" {
#     name = "${var.project_name}-ec2-policy"
#     role = aws_iam_role.ec2_role.id
#     policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [
#             {
#                 Effect = "Allow"
#                 Action = [
#                     "s3:GetObject",  # read a file from S3
#                     "s3:ListBucket"  # list files in S3 bucket
#                 ]
#                 Resource = [
#                     "arn:aws:s3:::${var.s3_bucket_name}",
#                     "arn:aws:s3:::${var.s3_bucket_name}/*"
#                 ]
#             }
#         ]
#     })
# }




#==================================================================================
#----------IAM Role----------
# Console: IAM → Roles → Create role
# Trusted entity: AWS service → EC2
#---AWS Console IAM ROle Step 1: Select trusted entity---
resource "aws_iam_role" "ssm_role" {

    # Console: "Trusted entity type = AWS service, Use case = EC2"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = {Service = "ec2.amazonaws.com"}
                Action = "sts:AssumeRole"
            }
        ]
    })

    tags = {
        Name = "${var.project_name}-ssm-role"
    }

}

#----------Attach SSM Policy(Add Permissions or, Permissions Policies) to Role----------
# Console: Add permissions → search "AmazonSSMManagedInstanceCore" → tick it
#---AWS Console IAM ROle Step 2:Add permissions---
resource "aws_iam_role_policy_attachment" "ssm_permissions_policy" {

    # Add the aws_iam_role(ssm_role)
    role = aws_iam_role.ssm_role.name

    # add the policy
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  
}

#----------Instance Profile----------
# Console: This is auto-created behind the scenes when you attach a role to EC2
# In Terraform you must create it manually and attach to EC2

# This resource mainly attached the role to EC2 in the console via Actions → Security → Modify IAM role, AWS silently created an Instance Profile wrapper around the role.
# Terraform does not do this automatically. That is why I need the aws_iam_instance_profile block. Without it, I cannot attach the role to EC2 in Terraform.
resource "aws_iam_instance_profile" "ssm_profile" {

    name = "${var.project_name}-ssm-profile"

    # Add the aws_iam_role(ssm_role)
    role = aws_iam_role.ssm_role.name

    tags = {
        Name = "${var.project_name}-ssm-profile"
    }
  
}
#==================================================================================

