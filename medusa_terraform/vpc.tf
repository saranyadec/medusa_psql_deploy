
# VPC creation
resource "aws_vpc" "medusa" {
  cidr_block = "10.0.0.0/16"
}

# public subnet creation
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.medusa.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a" 
}

# private subnet creation
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.medusa.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"  
}

# internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.medusa.id
}

# NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
}

# Allocation Elastic IP for NAT gateway
resource "aws_eip" "nat" {
  vpc = true
}

# Create route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.medusa.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.medusa.id
}

# Associate public subnet with public route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Associate private subnet with private route table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}


#cloudwatch log group and log stream 
resource "aws_cloudwatch_log_group" "medusa_ecs_logs" {
  name = "/medusaqa/logs"
  retention_in_days = 3
}

resource "aws_cloudwatch_log_stream" "medusa_ecs_logs_stream" {
  name           = "medusaqa_stream"
  log_group_name = aws_cloudwatch_log_group.medusa_ecs_logs.name
}


data "aws_iam_role" "kb_ecs_task_execution_role" {
  name = "ecs-task-execution-role"  
}

data "aws_iam_role" "ecs-service-role" {
  name = "ecs-role"
}


resource "aws_ecr_repository" "medusa-ecr" {
  name                 = "medusa-repo-ecr"
  image_tag_mutability = "IMMUTABLE"  
  scan_on_push         = true   
}


resource "aws_security_group" "ecs_security_group" {
  name        = "ecs-security-group"
  description = "Security group for ECS allowing all TCP traffic"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "postgresql_sg" {
  name        = "postgresql-sg"
  description = "Security group for PostgreSQL instance"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["aws_security_group.ecs_security_group.id"]  
  }

  # Egress rule to allow all outbound traffic (0.0.0.0/0)
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"  # All protocols
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # You can add more ingress/egress rules as needed
}
