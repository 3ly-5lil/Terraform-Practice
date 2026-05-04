locals {
  public_subnets = {
    for key, config in var.subnet_config : key => config if config.public
  }

  private_subnets = {
    for key, config in var.subnet_config : key => config if !config.public
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_configs.cidr

  tags = merge(
    { Name = var.vpc_configs.name },
    local.common_tags
  )
}

resource "aws_subnet" "this" {
  for_each = var.subnet_config
  vpc_id   = aws_vpc.main.id


  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.public

  tags = merge(
    { Name = each.key },
    local.common_tags
  )

  lifecycle {
    precondition {
      condition     = contains(data.aws_availability_zones.available.names, each.value.az)
      error_message = <<-EOT
      The specified availability zone "${each.value.az}" for subnet ${each.key} is not available in the current region.
      Please provide a valid availability zone from the list of available zones: ${join(", ", data.aws_availability_zones.available.names)}.
      EOT
    }
  }
}

resource "aws_internet_gateway" "igw" {
  count = length(local.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main.id
  tags = merge(
    { Name = "${var.vpc_configs.name}-igw" },
    local.common_tags
  )
}

resource "aws_route_table" "public" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }

}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnets

  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.this[each.key].id
}
