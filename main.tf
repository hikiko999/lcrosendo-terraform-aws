terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.10"
    }
  }
  backend "s3" {
    bucket         = "lcrosendo-projects-s3-backend"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "lcrosendo-projects-dynamodb-backend"
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = "LCROSENDO-P-TERRAFORM-AWS"
    }
  }
}

module "backend" {
  source = "./backend"
}

# Configure the AWS Provider

# Configured Backend-State Bucket

resource "aws_s3_bucket" "lcrosendo-projects-s3-main" {
  bucket = "lcrosendo-projects-s3-main"
}

resource "aws_s3_bucket_versioning" "lcrosendo-projects-s3-main-VERSIONING" {
  bucket = aws_s3_bucket.lcrosendo-projects-s3-main.id
  versioning_configuration {
    status = "Enabled"
  }
}