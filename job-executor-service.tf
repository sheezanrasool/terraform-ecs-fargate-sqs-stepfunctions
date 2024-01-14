resource "aws_ecs_cluster" "am_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_sqs_queue" "am_queue" {
  name = var.sqs_queue_name
}

resource "aws_ecs_task_definition" "am_task_definition" {
  family                   = "am-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" 
  memory                   = "512"  

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "my-container",
      image = "docker-image:latest",  
    },
  ])
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "am-ecs-service"
  cluster         = aws_ecs_cluster.am_cluster.id
  task_definition = aws_ecs_task_definition.am_task_definition.arn
  desired_count   = "1"
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = values(aws_subnet.AM-private-subnet)[*].id
    assign_public_ip = false
  }
}

## We can specify Autoscaling for Above ECS Cluster as well ##

resource "aws_sfn_state_machine" "ecs_state_machine" {
  name     = "ecs-state-machine"
  role_arn = aws_iam_role.iam_for_sfn.arn

  definition = <<EOF
{
  "Comment": "My State Machine",
  "StartAt": "MyFargateTask",
  "States": {
    "MyFargateTask": {
      "Type": "Task",
      "Resource": "aws_ecs_task_definition.am_task_definitionn.arn",
      "End": true
    }
  }
}
EOF
}

## In the definition we would need to update the entire error handling flow ##

resource "aws_iam_role" "iam_for_sfn" {
  name = "stepFunctionSampleStepFunctionExecutionIAM"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

## Attach the relevant policies for step functions ##