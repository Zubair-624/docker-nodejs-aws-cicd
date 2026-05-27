# ----------Latest Ubuntu 24.04 AMI----------
# data block = reads existing AWS data, does NOT create anything
# most_recent = true → always gets latest Ubuntu 24.04 patch
# owners = Canonical's official AWS account ID — never hardcode AMI ID
data "aws_ami" "ubuntu_24_04" {
    most_recent = true
    owners      = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

#----------EC2 Instance (App Server)----------
resource "aws_instance" "main" {
    tags = {
        Name = "${var.project_name}-app-server"
    }

    # AMI (OS Image) — Ubuntu 24.04
    ami = data.aws_ami.ubuntu_24_04.id

    # Instance type — t2.micro = free tier
    instance_type = var.instance_type

    # Key Pair — reusable key from devops-zubair-key repo
    key_name = var.key_name

    # Private subnet — app server hidden from internet
    # No direct internet access — only via bastion SSH
    # Outbound internet via NAT Gateway
    subnet_id = var.private_subnet_id

    # NO public IP — app server is private
    # Only bastion can reach it via SSH
    associate_public_ip_address = false

    # App server security group
    # Port 22   → only from bastion SG
    # Port 80   → open to everyone
    # Port 3000 → open to everyone
    vpc_security_group_ids = [var.security_group_ids]

    # Configure storage
    # gp3 = latest SSD type, faster and cheaper than gp2
    # delete_on_termination = disk deleted when EC2 terminated
    root_block_device {
        volume_size           = var.volume_size
        volume_type           = "gp3"
        delete_on_termination = true
    }

    # IAM instance profile — allows EC2 to read from S3
    # comes from modules/iam/outputs.tf
    # This is the Terraform equivalent of Actions → Security → Modify IAM role you did in the console.144804
    # ---Console: Actions → Security → Modify IAM role → select devops-lab-ssm-role, This one line = that entire console step---
    iam_instance_profile = var.iam_instance_profile

    
}