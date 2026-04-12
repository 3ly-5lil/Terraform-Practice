resource "aws_vpc" "proj-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "proj-vpc"
  }
}

resource "aws_subnet" "proj-public" {
  vpc_id                  = aws_vpc.proj-vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "proj-subnet-public"
  }
}

resource "aws_internet_gateway" "proj-igw" {
  vpc_id = aws_vpc.proj-vpc.id
  tags = {
    Name = "proj-igw"
  }
}

resource "aws_route_table" "proj-public-rtb" {
  vpc_id = aws_vpc.proj-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.proj-igw.id
  }

  tags = {
    Name = "proj-public-rtb"
  }
}

resource "aws_route_table_association" "proj-public-rtb-assoc" {
  subnet_id      = aws_subnet.proj-public.id
  route_table_id = aws_route_table.proj-public-rtb.id
}
