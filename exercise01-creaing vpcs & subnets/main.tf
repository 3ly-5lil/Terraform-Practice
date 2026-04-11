terraform {
  required_providers {
	aws = {
		source = "hashicorp/aws"
		version = "~>6.0"
	}
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "name" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "exercise-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.name.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "exercise-subnet-public"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.name.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "exercise-subnet-private"
  }
}

resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name
  tags = {
	Name = "exercise-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }

  tags = {
	Name = "exercise-public-rtb"
  }
}


resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}