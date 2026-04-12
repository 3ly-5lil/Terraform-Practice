resource "aws_instance" "proj-nginx" {
  ami                         = "ami-0ec10929233384c7f"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.proj-public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.proj-web-server-sg.id]
  tags = {
    Name = "proj-nginx"
  }

  root_block_device {
    delete_on_termination = true

  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
}

output "web_server_public_ip" {
  value       = aws_instance.proj-nginx.public_ip
  description = "Public IP of the NGINX web server"
}
