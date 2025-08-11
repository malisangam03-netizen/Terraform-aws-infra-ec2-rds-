resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
    encrypted   = true
    iops        = 3000
    throughput  = 125
  }

  tags = {
    Name        = "${var.project_name}-ec2-${var.environment}"
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}
