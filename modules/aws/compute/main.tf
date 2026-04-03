resource "aws_security_group" "this" {
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
}