
# provider.tf
# Terraform version + AWS provider +
# Remote backend configuration
# ─────────────────────────────────────────

terraform {
  required_version = ">= 1.8.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote backend — uncomment after creating S3 bucket
   backend "s3" {
     bucket = "devops-bootcamp-tfstate-1773832286"
     key    = "week6/ecs/terraform.tfstate"
     region = "us-east-1"
   }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "devops-bootcamp"
      Environment = "dev"
      ManagedBy   = "terraform"
      Repository  = "jan26-devops-bootcamp"
    }
  }
}
