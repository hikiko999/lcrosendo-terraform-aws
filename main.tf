terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = "LCROSENDO-P-TERRAFORM-AWS"
    }
  }
}

resource "aws_s3_bucket" "lcrosendo-projects-s3" {
  bucket = "lcrosendo-projects-s3"
}

resource "aws_s3_bucket_versioning" "lcrosendo-projects-s3-VERSIONING" {
  bucket = aws_s3_bucket.lcrosendo-projects-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}