resource "aws_db_instance" "rds-sql" {
  identifier              = var.env_code
  allocated_storage       = 10
  db_name                 = var.db_name  
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  username                = var.db_username 
  password                = var.rds_password 
  multi_az                = true
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  backup_retention_period = 35
  backup_window           = "21:00-23:00"
}

