output "vpc_id" {
  description = "The AWS ID from the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "The public subnets in the VPC"
  value = { for key in keys(local.public_subnets) : key => {
    id                = aws_subnet.this[key].id
    cidr_block        = aws_subnet.this[key].cidr_block
    availability_zone = aws_subnet.this[key].availability_zone
  } }
}

output "private_subnets" {
  description = "The private subnets in the VPC"
  value = { for key in keys(local.private_subnets) : key => {
    id                = aws_subnet.this[key].id
    cidr_block        = aws_subnet.this[key].cidr_block
    availability_zone = aws_subnet.this[key].availability_zone
  } }
}
