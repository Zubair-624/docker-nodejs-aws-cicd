terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    profile = "zubair-devops"

    default_tags {
    tags = {
        Environment = "dev"
        CostCenter  = "learning"
        ManagedBy   = "terraform"
        Project = "docker-nodejs-aws-cicd"
        Owner   = "zubair"
    }
}
  
}