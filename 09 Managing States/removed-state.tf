removed {
  from = aws_instance.new
  lifecycle {
    destroy = false
  }
}
