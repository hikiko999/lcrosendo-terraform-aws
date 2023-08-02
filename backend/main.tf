provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = "LCROSENDO-P-TERRAFORM-AWS"
    }
  }
}

resource "aws_s3_bucket" "lcrosendo-projects-s3-backend" {
  bucket = "lcrosendo-projects-s3-backend"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "lcrosendo-projects-s3-backend-VERSIONING" {
  bucket = aws_s3_bucket.lcrosendo-projects-s3-backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

# SS3 Encryption on by default

resource "aws_dynamodb_table" "lcrosendo-projects-dynamodb-backend" {
  name         = "lcrosendo-projects-dynamodb-backend"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }

}