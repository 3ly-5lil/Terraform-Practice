resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = "${local.project} - Terraform VPC"
    Project = local.project
  }
}

resource "aws_subnet" "this" {
  for_each = var.subnet_configs
  cidr_block = each.value.cidr

  vpc_id = aws_vpc.main.id
	
  tags = {
    Name    = "${local.project} - Terraform Subnet ${each.key}"
    Project = local.project
  }
}
