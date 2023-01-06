resource "aws_db_subnet_group" "main" {
  name       = var.env_code
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.env_code
  }
}

resource "aws_security_group" "rds_sg" {
  name   = "${var.env_code}-rds"
  vpc_id = var.vpc_id

  ingress {
    description     = "http from the asg"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.source_Security_group]
  }

  tags = {
    Name = "${var.env_code}-rds"
  }
}

