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

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.0"

  name          = "instance-for-module"
  instance_type = "t3.micro"
  monitoring    = true

  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.vpc.default_security_group_id]

  tags = local.common_tags
}
