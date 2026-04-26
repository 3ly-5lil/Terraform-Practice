resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = "${local.project} - Terraform VPC"
    Project = local.project
  }
}

resource "aws_subnet" "this" {
  count      = var.subnet_count
  cidr_block = "10.0.${count.index}.0/24"

  vpc_id = aws_vpc.main.id
	
  tags = {
    Name    = "${local.project} - Terraform Subnet ${count.index + 1}"
    Project = local.project
  }
}
