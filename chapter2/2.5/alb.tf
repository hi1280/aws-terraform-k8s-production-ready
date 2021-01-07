resource "aws_lb" "example" {
  name               = "eks-example"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_example.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

resource "aws_lb_target_group" "example" {
  name     = "eks-example"
  port     = 30001
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}