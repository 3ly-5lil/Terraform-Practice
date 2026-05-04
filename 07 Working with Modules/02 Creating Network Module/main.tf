module "vpc" {
  source = "./modules/networking"

  vpc_configs = {
    cidr = "10.0.0.0/16"
    name = "My VPC"
  }

  subnet_config = {
    subnet1 = {
      az         = "us-east-1a"
      cidr_block = "10.0.0.0/24"
      public     = true
    }
    subnet2 = {
      az         = "us-east-1a"
      cidr_block = "10.0.1.0/24"
      public     = false
    }
  }
}

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


resource "aws_instance" "main" {
  ami = data.aws_ami.ubuntu.id

  subnet_id = module.vpc.public_subnets["subnet1"].id

  tags = {
    Name = "EC2 Instance in Public Subnet"
  }
}