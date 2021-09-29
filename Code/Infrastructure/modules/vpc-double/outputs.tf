
output "vpc_id" {
    value = aws_vpc.main.id
}

output "vpc_arn" {
    value = aws_vpc.main.arn
}

output "vpc_cidr" {
    value = aws_vpc.main.cidr_block
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
}

output "subnet_public_id" {
    value = aws_subnet.public.id
}

output "subnet_private1_id" {
    value = aws_subnet.private1.id
}


output "subnet_private2_id" {
    value = aws_subnet.private2.id
}

output "private_rt_id" {
    value = aws_route_table.private.id
}
