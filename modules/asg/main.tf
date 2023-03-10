data "aws_ami" "linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.image_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_configuration" "main" {

  name_prefix          = "${var.env_code}-launch-config"
  image_id             = data.aws_ami.linux-image.id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.private.id]
  iam_instance_profile = aws_iam_instance_profile.main.name
  
  user_data = templatefile("${path.module}/user-data.tpl",
    { db_username = var.db_username,
      db_password = var.rds_password,
      db_name     = var.db_name,
      rds_endpoint = var.rds_endpoint })

  key_name = "ansible"
}

resource "aws_autoscaling_group" "main" {
  name             = var.env_code
  min_size         = 2
  max_size         = 5
  desired_capacity = 2

  target_group_arns    = [var.target-group]
  launch_configuration = aws_launch_configuration.main.name
  vpc_zone_identifier  = var.vpc_zone_identifier


  tag {
    key                 = "Name"
    value               = "${var.env_code}-asg"
    propagate_at_launch = true
  }
}

