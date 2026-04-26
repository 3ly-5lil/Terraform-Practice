data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "main" {
  count = var.ec2_instance_count

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.this[
    count.index % var.subnet_count
  ].id

  tags = {
    Project = local.project
    Name    = "${local.project} - Instance ${count.index}"
  }
}
