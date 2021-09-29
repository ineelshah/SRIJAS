variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "db_user_name" {}
variable "db_password" {}

variable "aws_region" {
    default = "us-west-1"
}


variable "ec2_count" {                                   
  default = "1"
}

variable "ami_id" {
    // Ubuntu Server 18.04 LTS (HVM), SSD Volume Type in us-east-1 
    default = "ami-09e67e426f25ce0d7"
}

variable "instance_type" {
  default = "t2.micro"
}

// variable "subnet_id" {}

