resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.project_name}-rds-subnet-group-${var.environment}"
  description = "RDS subnet group"
  subnet_ids  = data.aws_subnets.default.ids

  tags = {
    Name        = "${var.project_name}-rds-subnet-group-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg-${var.environment}"
  description = "Security group for ${var.project_name} RDS allowing DB access from web SG"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description     = "DB access from web SG"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-rds-sg-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_db_instance" "rds" {
  identifier                  = "${var.project_name}-rds-${var.environment}"
  allocated_storage           = var.db_allocated_storage
  engine                      = var.db_engine
  engine_version              = var.db_engine_version
  instance_class              = var.db_instance_class
  db_name                     = var.db_name
  username                    = var.db_username
  password                    = var.db_password
  port                        = var.db_port

  vpc_security_group_ids      = [aws_security_group.rds_sg.id]
  db_subnet_group_name        = aws_db_subnet_group.rds_subnet_group.name
  publicly_accessible         = false

  backup_retention_period     = 7

  skip_final_snapshot         = true
  deletion_protection         = false

  tags = {
    Name        = "${var.project_name}-rds-${var.environment}"
    Environment = var.environment
  }
}


