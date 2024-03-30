
resource "aws_ecs_cluster" "medusa_cluster" {
  name             = "medusa-ecs-cluster"
  capacity_providers = ["FARGATE"]
  
  tags = {
    Environment = "Production"
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "medusa_task_definition" {
  family                   = "ecs-medusa"
  network_mode             = "awsvpc"
  cpu                      = "256"  # CPU units for the task
  memory                   = "512"  # Memory limit for the task in MB

  container_definitions = jsonencode([
    {
      name      = "medusa-backend-project"
      image     = ":latest"       
      environment = [
        {
          name  = "RDS_DB_HOSTNAME"
          value = "localhost"  # Replace with your PostgreSQL host
        },
        {
          name  = "RDS_DB_NAME"
          value = "medusa_backend"  # Replace with your PostgreSQL database name
        },
        {
          name  = "RDS_DB_USER"
          value = "postgres"  # Replace with your PostgreSQL username
        },
        {
          name  = "RDS_DB_PASSWORD"
          value = var.RDS_DB_PASSWORD  # Replace with your PostgreSQL password
        },
      ]

      portMappings = [
        {
          containerPort = 9000  
          hostPort      = 9000  
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "medusa_ecs_service" {
  name            = "medusa-ecs-service"
  cluster         = aws_ecs_cluster.medusa_cluster.id  
  task_definition = aws_ecs_task_definition.medusa_task_definition.arn  
  desired_count = 1    deployment_controller {
    type = "ECS"
  }

  network_configuration {
    subnets         = [aws_subnet.public.id]  
    security_groups = [aws_security_group.ecs_security_group.id]  
  }
}

