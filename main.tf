terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 1.1.0"
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "stech-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2"   
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-034ef92d9dd822b08"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

