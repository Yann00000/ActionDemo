resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-buckehhhhh"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


terraform {
  required_version = ">= 1.2.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.34.0"
    }
  }

  backend "s3" {
    encrypt        = true
    bucket         = "tf_org_statefile"
    dynamodb_table = "terraform-backend-lock"
    region         = "us-west-1"
    key            = "stg/test/terraform.tfstate"
  }

}


resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}