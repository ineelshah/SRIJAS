# declaring aws as required provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider with access key and secret key present in terraform.tfvars file
provider "aws" {
  region = "us-east-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

# creating vpc using module
module "vpc" {
    source = "../modules/vpc-double"
    vpc_name = "db-sample"
    vpc_cidr = "192.168.0.0/16"
    public_cidr = "192.168.1.0/24"
    private1_cidr = "192.168.2.0/24"
    private2_cidr = "192.168.3.0/24"
    private1_az = data.aws_availability_zones.available.names[0]
    private2_az = data.aws_availability_zones.available.names[1]
    public_az = data.aws_availability_zones.available.names[0]
}

data "aws_availability_zones" "available" {
  state = "available"
}
