data "aws_secretsmanager_secret" "rds_secret" {
  name = "prod/wordpress-password/sql"
}


data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.id
}


locals {
  rds_password = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["wordpress-password"]
}

