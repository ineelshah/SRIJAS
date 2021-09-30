# defining the outputs needed after completion of execution

# outputs for ec2 webserver
output "ec2-webserver-dns" {
    value = aws_instance.ec2-webserver.public_dns
}

output "ec2-webserver-ip" {
    value = aws_instance.ec2-webserver.public_ip
}

output "ec2-webserver-private-dns" {
    value = aws_instance.ec2-webserver.private_dns
}

output "ec2-webserver-private-ip" {
    value = aws_instance.ec2-webserver.private_ip
}

# outputs for ec2 scrapping server
output "ec2-scrapper-dns" {
    value = aws_instance.ec2-scrapper.public_dns
}

output "ec2-scrapper-ip" {
    value = aws_instance.ec2-scrapper.public_ip
}

output "ec2-scrapper-private-dns" {
    value = aws_instance.ec2-scrapper.private_dns
}

output "ec2-scrapper-private-ip" {
    value = aws_instance.ec2-scrapper.private_ip
}

# outputs for rds db instance
output "db-address" {
    value = aws_db_instance.default.address
}

output "db-arn" {
    value = aws_db_instance.default.arn
}

output "db-domain" {
    value = aws_db_instance.default.domain
}

output "db-endpoint" {
    value = aws_db_instance.default.endpoint
}

output "db-hosted_zone_id" {
    value = aws_db_instance.default.hosted_zone_id
}

output "db-id" {
    value = aws_db_instance.default.id
}

output "db-name" {
    value = aws_db_instance.default.name
}

output "db-port" {
    value = aws_db_instance.default.port
}
