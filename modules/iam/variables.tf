#----------Project Name----------
variable "project_name" {

    description = "Project name used for naming all resources"
    type = string
  
}

#----------S3 Bucket Name----------
variable "s3_bucket_name" {

    description = "S3 bucket name"
    type = string
    default = "devops-zubair-terraform-state"
  
}