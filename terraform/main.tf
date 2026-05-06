#----------VPC Module----------
module "vpc" {

    source = "../modules/vpc"

    project_name = var.project_name

    cidr_block = var.cidr_block

    public_subnet_one_cidr = var.public_subnet_cidr_one

    az = var.az

}

#----------Security Group Module----------
module "security_group" {

    source = "../modules/security_group"

    project_name = var.project_name

    main_vpc_id = module.vpc.main_vpc_id

    ssh_cidr = var.ssh_cidr
  
}

#----------IAM Role - allows EC2 to read from S3----------
module "iam" {

    source = "../modules/iam"

    project_name = var.project_name

    s3_bucket_name = var.s3_bucket_name
  
}

#----------EC2 Module----------
module "ec2" {

    source = "../modules/ec2"

    project_name = var.project_name

    instance_type = var.instance_type

    key_name = var.key_name

    #come from modules/vpc/outputs.tf
    #(vpc + subnet + az)
    public_subnet_ids = module.vpc.public_subnet_ids

    #come from modules/security_group/outputs.tf
    security_group_ids = module.security_group.security_group_ids

    iam_instance_profile = module.iam.aws_iam_instance_profile_name


}