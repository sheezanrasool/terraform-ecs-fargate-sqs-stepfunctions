#  Create an EC2 Auto Scaling Group - backend
resource "aws_autoscaling_group" "backend-asg" {
  name                 = "backend-asg"
  launch_configuration = aws_launch_configuration.backend-lconfig.id
  vpc_zone_identifier  = values(aws_subnet.AM-private-subnet)[*].id
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
}

# Create a launch configuration for the EC2 instances
resource "aws_launch_configuration" "backend-lconfig" {
  name_prefix                 = "backend-lconfig"
  image_id                    = var.ami_id
  instance_type               = var.instance_type
  user_data                   = <<-EOF
                                #!/bin/bash

                                sudo yum install mysql -y
                                sudo yum install java-11-openjdk -y

                                EOF
                                
  associate_public_ip_address = false
  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}