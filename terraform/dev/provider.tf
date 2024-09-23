# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
  backend "http" {} # Store state in a remote HTTP server that is GitLab
}

provider "aws" {}
