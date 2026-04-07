//New Config with ALB Implementation
resource "aws_security_group" "alb" {
  name = "${var.name}-alb-sg"
  description = "Security Group for ${var.name} ALB"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-alb-sg"
  }
}

resource "aws_security_group" "ec2" {
  name = "${var.name}-ec2-sg"
  description = "Security Group for ${var.name} EC2 Instances"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTP from ALB"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22 
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-ec2-sg"
  }
}

resource "aws_lb" "this" {
  name = "${var.name}-alb"
  internal = false 
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = var.public_subnets

  tags = {
    Name = "${var.name}-alb"
  }
}

resource "aws_lb_target_group" "this" {
  name = "${var.name}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    enabled = true
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    timeout = 5
  }

  tags = {
    Name = "${var.name}-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn 
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn 
  }
}

resource "aws_launch_template" "this" {
  name_prefix = "${var.name}-lt-"
  image_id = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.ec2.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "<h1>${var.name} app server</h1>" > /var/www/html/index.html
              echo "<p>Hostname: $(hostname)</p>" >> /var/www/html/index.html
              EOF
  )
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name}-ec2"
    }
  }
}

resource "aws_autoscaling_group" "this" {
  name = "${var.name}-asg"
  desired_capacity = var.desired_capacity
  min_size = var.min_size
  max_size = var.max_size
  vpc_zone_identifier = var.public_subnets
  target_group_arns = [aws_lb_target_group.this.arn]
  health_check_type = "ELB"

  launch_template {
    id = aws_launch_template.this.id 
    version = "$Latest"
  }

  tag {
    key = "Name"
    value = "${var.name}-asg-instance"
    propagate_at_launch = true
  }
}

//Original Older Config For Reference (Without ALB)
/*resource "aws_security_group" "this" {
  name = "${var.name}-ec2-sg"
  description = "Security group for ${var.name} EC2 instance"
  vpc_id = var.vpc_id

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-ec2-sg"
  }
}

resource "aws_instance" "this" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.this.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.name}-ec2"
  }
}*/