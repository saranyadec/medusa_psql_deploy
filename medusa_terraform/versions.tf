terraform {
  required_version = "~> 1.3.5"  
  required_providers { 
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
  backend "s3" {
    bucket         = "data-state-tf"
    key            = "terraform-ecs2.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}


# configure aws provider
provider "aws" {
    region  = var.region
}