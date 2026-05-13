# ============================================================
# Bastion Host — the ONLY entry point to private network
# Lives in PUBLIC subnet
# Has public IP — accessible from internet via SSH
# Used to jump into app server in private subnet
# ============================================================

#----------Latest Ubuntu 24.04 AMI----------
# data block = reads existing AWS data, does NOT create anything
# most_recent = true → always gets latest Ubuntu 24.04 patch
# owners = Canonical's official AWS account ID — never hardcode AMI ID
data "aws_ami" "ubuntu_24_04" {
    most_recent = true
    owners      = ["099720109477"]

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

#----------Bastion EC2 Instance----------
resource "aws_instance" "bastion" {
    tags = {
        Name = "${var.project_name}-bastion"
    }

    # Ubuntu 24.04 — same as app server
    ami = data.aws_ami.ubuntu_24_04.id

    # t2.micro = free tier — bastion needs very low resources
    # it only forwards SSH connections, nothing else
    instance_type = var.instance_type

    # Reusable SSH key from devops-zubair-key repo
    key_name = var.key_name

    # Lives in PUBLIC subnet — needs public IP to be reachable
    subnet_id = var.public_subnet_id
    associate_public_ip_address = true

    # Only bastion security group attached
    # allows SSH from anywhere (protected by .pem key)
    vpc_security_group_ids = [var.bastion_sg_id]

    # Small storage — bastion only needs minimal disk
    root_block_device {
        volume_size = 8
        volume_type = "gp3"
        delete_on_termination = true
    }
}

#----------Elastic IP for Bastion----------
# Fixed permanent public IP for bastion
# Never changes even if EC2 restarts
# Use this as SSH entry point forever — no IP change problem!
resource "aws_eip" "bastion" {
    instance = aws_instance.bastion.id
    domain = "vpc"
    tags = {
        Name = "${var.project_name}-bastion-eip"
    }
}