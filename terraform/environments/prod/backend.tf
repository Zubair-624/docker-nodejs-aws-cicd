terraform {
    backend "s3" {
        bucket         = "devops-zubair-terraform-state"
        key            = "docker-nodejs-aws-cicd/terraform.tfstate"
        region         = "us-east-1"
        profile        = "zubair-devops"
        use_lockfile   = true
        encrypt        = true
    }
}

