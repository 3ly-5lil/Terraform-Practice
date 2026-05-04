data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = "vpc-from-module"
  cidr = "10.0.0.0/16"

  private_subnets = ["10.0.0.0/24"]
  public_subnets  = ["10.0.128.0/24"]

  azs  = data.aws_availability_zones.azs.names
  tags = local.common_tags
}
