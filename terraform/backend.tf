terraform {
    backend "s3" {
        bucket         = "devops-zubair-terraform-state"
        key            = "docker-nodejs-aws-cicd/terraform.tfstate"
        region         = "us-east-1"
        profile        = "zubair-devops"
        dynamodb_table = "devops-zubair-terraform-lock"
        encrypt        = true
    }
}

