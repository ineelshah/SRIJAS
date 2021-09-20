
resource "aws_instance" "ec2-webserver" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = module.vpc.subnet_public_id
    key_name      = "terraform-key"
    vpc_security_group_ids = [ aws_security_group.ec2-sg.id ]
    associate_public_ip_address = true

    tags = {
        Name = "SRIJAS-web-server"
    }

    depends_on = [ module.vpc.vpc_id, module.vpc.igw_id, aws_db_instance.default ]

    user_data = <<EOF
#!/bin/sh
sudo apt-get update
sudo apt-get install -y mysql-client
echo ${aws_db_instance.default.address} >/tmp/dbdomain.txt
sudo mv /tmp/dbdomain.txt /dbdomain.txt
#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo bash -c 'echo terraform server > /var/www/html/index.html'
sudo bash -c 'echo CREATE DATABASE newTrial > /tmp/sample.sql'
mysql -u ${var.db_user_name} -h ${aws_db_instance.default.address} --password=${var.db_password} < /tmp/sample.sql
EOF
}

resource "aws_instance" "ec2-scrapper" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = module.vpc.subnet_public_id
    key_name      = "terraform-key"
    vpc_security_group_ids = [ aws_security_group.ec2-sg.id ]
    associate_public_ip_address = true

    tags = {
        Name = "SRIJAS-scrapping-server"
    }

    depends_on = [ module.vpc.vpc_id, module.vpc.igw_id, aws_db_instance.default ]
    user_data = <<EOF
#!/bin/sh
sudo apt update
sudo apt-get install -y zip unzip 
sudo apt install -y python3
sudo apt install -y unzip libnss3 python3-pip 
sudo apt install python3-virtualenv -y 
#!/bin/bash
virtualenv -q -p /usr/bin/python3.8 $1
source $1/bin/activate
$1/bin/pip install selenium
cd /tmp
sudo wget https://chromedriver.storage.googleapis.com/93.0.4577.63/chromedriver_linux64.zip
sudo unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
chromedriver --version
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb 
google-chrome-stable --version
EOF
}

resource "aws_security_group" "ec2-sg" {
  name        = "security-group"
  description = "allow inbound access to the EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
