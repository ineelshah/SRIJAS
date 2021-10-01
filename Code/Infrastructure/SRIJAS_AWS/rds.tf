# defining the parameters group for rds instance
resource "aws_db_parameter_group" "default" {
  # choosing mysql8.0 for rds
  name   = "rds-pg"
  family = "mysql8.0"

  # setting the name and enccoding for DB for client and server
  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

# describing the default subnet group 
resource "aws_db_subnet_group" "default" {
  name       = "main"

  # using the private subnets for subnet group
  subnet_ids = [ module.vpc.subnet_private1_id , module.vpc.subnet_private2_id ]

  # adding the name tag for subnet group
  tags = {
    Name = "SRIJAS-db-subnet-group"
  }
}

# desrcribing the security group for rds
resource "aws_security_group" "rds-sg" {
  name        = "rds-security-group"
  description = "allow inbound access to the database"
  vpc_id      = module.vpc.vpc_id

  # allowing tcp traffic on port 3306 
  ingress {
    //protocol    = "tcp"
    //from_port   = 0
    //to_port     = 3306
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [ module.vpc.vpc_cidr ]
  }

  # allowing all outboud traffic from rds
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [ module.vpc.vpc_cidr ]
  }
}

# describing the rds db instance
resource "aws_db_instance" "default" {
  # setting storage, tpye, engine, class and other required parameters for rds db instance
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  identifier           = "srijas"
  name                 = "srijas"
  username             = "${var.db_user_name}"
  password             = "${var.db_password}"
  parameter_group_name = aws_db_parameter_group.default.id
  db_subnet_group_name = aws_db_subnet_group.default.id
  vpc_security_group_ids = [ aws_security_group.rds-sg.id ]

  # setting public assessibility false
  publicly_accessible  = false
  skip_final_snapshot  = true
  multi_az             = false
}