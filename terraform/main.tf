#----------VPC Module----------
# Creates: VPC, IGW, public subnet, private subnet
#          NAT Gateway, EIP for NAT
#          public RT, private RT, RT associations
# Outputs: main_vpc_id, public_subnet_ids, private_subnet_ids
module "vpc" {
    source = "../modules/vpc"

    project_name            = var.project_name
    aws_vpc_cidr_block      = var.cidr_block
    public_subnet_one_cidr  = var.public_subnet_cidr_one
    private_subnet_one_cidr = var.private_subnet_cidr_one
    az                      = var.az
}

#----------Security Group Module----------
# Creates: bastion SG + app server SG with all rules
# Depends on: module.vpc.main_vpc_id
# Outputs: bastion_sg_ids, app_sg_ids
module "security_group" {
    source = "../modules/security_group"

    project_name     = var.project_name
    main_vpc_id      = module.vpc.main_vpc_id
    allowed_ssh_cidr = var.ssh_cidr
}

#----------IAM Module----------
# Creates: IAM Role, IAM Policy (S3 read), IAM Instance Profile
# Outputs: aws_iam_instance_profile_name, iam_role_name
module "iam" {
    source = "../modules/iam"

    project_name   = var.project_name
    s3_bucket_name = var.s3_bucket_name
}

#----------Bastion Module----------
# Creates: Bastion EC2 in public subnet + Elastic IP
# Depends on: module.vpc.public_subnet_ids
#             module.security_group.bastion_sg_ids
# Outputs: bastion_public_ip, bastion_instance_id, bastion_private_ip
module "bastion" {
    source = "../modules/bastion"

    project_name     = var.project_name
    public_subnet_id = module.vpc.public_subnet_ids
    bastion_sg_id    = module.security_group.bastion_sg_ids
}

#----------EC2 Module (App Server)----------
# Creates: App server EC2 in PRIVATE subnet — no public IP
# Depends on: module.vpc.private_subnet_ids
#             module.security_group.app_sg_ids
#             module.iam.aws_iam_instance_profile_name
# Outputs: aws_instance_ids, private_ip, public_dns
module "ec2" {
    source = "../modules/ec2"

    project_name         = var.project_name
    instance_type        = var.instance_type
    key_name             = var.key_name
    private_subnet_id    = module.vpc.private_subnet_ids
    security_group_ids   = module.security_group.app_sg_ids
    iam_instance_profile = module.iam.aws_iam_instance_profile_name
}