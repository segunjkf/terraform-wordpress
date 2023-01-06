resource "aws_lb" "main-elb" {
  name               = "main-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balanacer-sg.id]
  subnets            = var.subnets
  tags = {
    Environment = "${var.env_code}-loadbalancer-my-sg"
  }
}

resource "aws_lb_target_group" "main" {
  name     = "tf-main-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    port                = "traffic-port"
    path                = "/"
    interval            = "30"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main-elb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.acm-arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

