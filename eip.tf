resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id
  domain   = "vpc"

  tags = {
    Name        = "web-eip-${var.environment}"
    Environment = var.environment
  }
}
