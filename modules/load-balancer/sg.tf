resource "aws_security_group" "load_balanacer-sg" {
  name        = "${var.env_code}-load-balancer"
  description = "Allow HTTPS to the load balanacer"
  vpc_id      = var.vpc_id

  ingress {
    description = "TCP FROM ANYWHERE"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_code}-loadbalancer-my-sg"
  }
}

