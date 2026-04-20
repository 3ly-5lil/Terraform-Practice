output "vpc_id" {
  value = data.aws_vpc.current
}

output "azs" {
  value = data.aws_availability_zones.available.names
}

output "subnet_ids" {
  value = data.aws_subnets.subnets.ids
}