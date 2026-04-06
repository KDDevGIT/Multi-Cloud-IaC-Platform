resource "aws_db_subnet_group" "this" {
  name = "${var.name}-db-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}

resource "aws_security_group" "this" {
  name = "${var.name}-rds-sg"
  description = "Security group for ${var.name} RDS"
  vpc_id = var.vpc_id

  ingress {
    description = "PostgreSQL"
    from_port = var.port
    to_port = var.port
    protocol = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-rds-sg"
  }
}

resource "aws_db_instance" "this" {
  identifier = "${var.name}-postgres"
  allocated_storage = var.allocated_storage
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  username = var.db_username
  password = var.db_password
  db_name = var.db_name
  port = var.port

  db_subnet_group_name = aws_db_subnet_group.this.name 
  vpc_security_group_ids = [aws_security_group.this.id]

  publicly_accessible = false 
  skip_final_snapshot = true
  deletion_protection = false 
  multi_az = false 

  tags = {
    Name = "${var.name}-postgres"
  }
}