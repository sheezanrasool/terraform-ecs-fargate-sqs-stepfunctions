######## Create an EC2 Auto Scaling Group - Frontend ############
resource "aws_autoscaling_group" "frontend-asg" {
  name                 = "frontend-asg"
  launch_configuration = aws_launch_configuration.frontend-lconfig.id
  vpc_zone_identifier  = values(aws_subnet.AM-public-subnet)[*].id
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
}

###### Create a launch configuration for the EC2 instances #####
resource "aws_launch_configuration" "frontend-lconfig" {
  name_prefix                 = "frontend-lconfig"
  image_id                    = var.ami_id
  instance_type               = var.instance_type
  user_data                   = <<-EOF
                                #!/bin/bash

                                # Update the system
                                sudo yum -y update

                                # Install Apache web server
                                sudo yum -y install httpd

                                # Start Apache web server
                                sudo systemctl start httpd.service

                                # Enable Apache to start at boot
                                sudo systemctl enable httpd.service

                                EOF
                                
  associate_public_ip_address = true
  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}
