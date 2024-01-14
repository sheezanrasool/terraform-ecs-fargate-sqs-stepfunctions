# Create Load balancer - Frontend
resource "aws_lb" "frontend-lb" {
  name               = "frontend-lb"
  load_balancer_type = "application"
  subnets            = values(aws_subnet.AM-public-subnet)[*].id

}

# create load balancer target group - Frontend

resource "aws_lb_target_group" "frontend-lb-tg" {
  name     = "frontend-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.AM-vpc.id

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Create Load Balancer listener - frontend
resource "aws_lb_listener" "frontend-lb-listner" {
  load_balancer_arn = aws_lb.frontend-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-lb-tg.arn
  }
}

# Register the instances with the target group - Frontend
resource "aws_autoscaling_attachment" "frontend-asattach" {
  autoscaling_group_name = aws_autoscaling_group.frontend-asg.name
  lb_target_group_arn   = aws_lb_target_group.frontend-lb-tg.arn
  
}

# Create Load balancer - backend
resource "aws_lb" "backend-lb" {
  name               = "backend-lb"
  internal           = true
  load_balancer_type = "application"
  subnets            = values(aws_subnet.AM-private-subnet)[*].id

}

# create load balancer target group - backend

resource "aws_lb_target_group" "backend-lb-tg" {
  name     = "backend-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.AM-vpc.id

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Create Load Balancer listener - backend
resource "aws_lb_listener" "backend-lb-listner" {
  load_balancer_arn = aws_lb.frontend-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-lb-tg.arn
  }
}

# Register the instances with the target group - backend
resource "aws_autoscaling_attachment" "backend-asattach" {
  autoscaling_group_name = aws_autoscaling_group.backend-asg.name
  lb_target_group_arn   = aws_lb_target_group.backend-lb-tg.arn
  
}