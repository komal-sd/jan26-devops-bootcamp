# provider.tf
# Terraform config + provider + s3backend


terraform {
  required_version = ">=1.8.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "devops-bootcamp"
      ManagedBy = "terraform"

    }
  }
}