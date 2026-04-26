locals {
  ami_ids = {
    "ubuntu"             = data.aws_ami.ubuntu.id
    "windows_sql_server" = data.aws_ami.windows_sql_server.id
  }
}

data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu*amd64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
data "aws_ami" "windows_sql_server" {
  owners      = ["801119661308"]
  most_recent = true

  filter {
    name   = "name"
    values = ["*Win*SQL*2017*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "main" {
  # for_each = var.ec2_instance_configs_map
  count = var.ec2_instance_configs.length

  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type

  subnet_id = aws_subnet.this[each.value.subnet_name].id

  tags = {
    Project = local.project
    Name    = "${local.project} - Instance ${each.key}"
  }
}
