data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/*-24.04-amd64-server*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


locals {
  idnetifiers = [
    "One",
    "Two"
  ]
}

resource "aws_instance" "new" {
  for_each = toset(local.idnetifiers)

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "EC2 Instance in Public Subnet"
  }
}

moved {
  from = aws_instance.new[0]
  to = aws_instance.new["One"]
}

moved {
  from = aws_instance.new[1]
  to = aws_instance.new["Two"]
}