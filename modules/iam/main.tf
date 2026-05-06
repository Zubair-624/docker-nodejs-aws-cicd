#IAM Instance Profile -> IAM Role -> IAM Policy

#----------IAM Instance Profile----------
#IAM Instance Profile Point to the -> IAM Role
resource "aws_iam_instance_profile" "ec2_profile" {

    tags = {
        Name = "${var.project_name}-ec2"
    }

    role = aws_iam_role.ec2_role.name
  
}

#----------IAM Role----------
#aws_iam_role -> defines WHO can use it (EC2)
#IAM Role point to the -> IAM Role Policy
resource "aws_iam_role" "ec2_role" {

    name = "${var.project_name}-ec2-role"

    tags = {
        Name = "${var.project_name}-ec2-role"
    }

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = "sts:AssumeRole"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
  
}

#----------IAM ROle Policy----------
#defines WHAT it can do (read S3)
#IAM Role Policy point to the -> IAM 
resource "aws_iam_role_policy" "ec2_policy" {

    name = "${var.project_name}-ec2-policy"

    role = aws_iam_role.ec2_role.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "s3:GetObject", # read a file from S3
                    "s3:ListBucket" # list files in S3 bucket
                ]
                Resource = [
                    "arn:aws:s3:::${var.s3_bucket_name}",
                    "arn:aws:s3:::${var.s3_bucket_name}/*"
                ]
            }
        ]
    })
  
}


