# describing the vpc in aws
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  # assigning the name tag
  tags = {
    Name = var.vpc_name
  }
}

# describing the internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  # assigning the name tag
  tags = {
    Name =  "${var.vpc_name}-IGW"
  }
}

# describing the route with route table and internet gateway
resource "aws_route" "route-public" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# describing the aws public subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr
  availability_zone = var.public_az

  tags = {
    Name = "${var.vpc_name}-net-public"
  }
}

# describing the aws private subnet 1
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private1_cidr
  availability_zone = var.private1_az

  tags = {
    Name = "${var.vpc_name}-net-private1"
  }
}

# describing the aws private subnet 2
resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private2_cidr
  availability_zone = var.private2_az

  tags = {
    Name = "${var.vpc_name}-net-private2"
  }
}

# generating elastic IP 
resource "aws_eip" "gw" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name =  "${var.vpc_name}-EIP"
  }
}

# describing the nat gateway
resource "aws_nat_gateway" "gw" {
  subnet_id     = aws_subnet.public.id
  allocation_id = aws_eip.gw.id

  tags = {
    Name =  "${var.vpc_name}-NAT"
  }
}

# describing the route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }

  tags = {
    Name =  "${var.vpc_name}-rt-private"
  }
}

# describing the route table association for public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_vpc.main.main_route_table_id
}

# describing the route table association for private subnet 1
resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

# describing the route table association for private subnet 2
resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}
