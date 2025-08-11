resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id
  domain   = "vpc"

  tags = {
    Name        = "${var.project_name}-eip-${var.environment}"
    Environment = var.environment
  }
}
