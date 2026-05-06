# ----------Latest Ubuntu 24.04 AMI----------
data "aws_ami" "ubuntu_24_04" {

    most_recent = true
    owners = ["099720109477"]

    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
  
}

#----------EC2 Instance----------
resource "aws_instance" "main" {

    tags = {
        Name = "${var.project_name}-ec2"
    }

    #AMI(OS Image)
    ami = data.aws_ami.ubuntu_24_04.id

    #Instance type
    instance_type = var.instance_type

    #Key Pair/Name(login)
    key_name = var.key_name

    #Network Settings(1st VPC, 2nd Subnet, AZ(Subnet Select auto connect to the AZ))
    subnet_id = var.public_subnet_ids

    #Auto-assign public IP(Enable)
    associate_public_ip_address = true 

    #Firewall (security groups)
    vpc_security_group_ids = [var.security_group_ids]

    #Configure storage 
    root_block_device {
      volume_size = var.volume_size
      volume_type = "gp3"
      delete_on_termination = true 
    }

    #IAM instance profile
    iam_instance_profile = var.iam_instance_profile
    

  
}