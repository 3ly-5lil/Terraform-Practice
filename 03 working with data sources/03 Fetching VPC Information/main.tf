data "aws_vpc" "current" {
  default = true
  filter {
    name = "Name"
    values =  "" 
  }
  tags = {
    Name = ""
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.current.id]
  }
}