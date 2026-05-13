#----------Project Name----------
variable "project_name" {
    description = "Project name used for naming all resources"
    type        = string
}

#----------S3 Bucket Name----------
# Already exists — created in devops-zubair-terraform-backend repo
# DO NOT recreate — shared across all projects
variable "s3_bucket_name" {
    description = "S3 bucket name for IAM policy - already exists"
    type        = string
    default     = "devops-zubair-terraform-state"
}