variable "name" {
  type        = string
  description = "Name for database resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the database SG will be created"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnet IDs for the DB subnet group"
}

variable "db_username" {
  type        = string
  description = "Master username for RDS instance"
}

variable "db_password" {
  type        = string
  description = "Master password for RDS instance"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "Database name"
  default     = "appdb"
}

variable "engine" {
  type        = string
  description = "Database Engine"
  default     = "postgres"
}

variable "engine_version" {
  type        = string
  description = "Database Engine Version"
  default     = "16.3"
}

variable "instance_class" {
  type        = string
  description = "RDS Instance Class"
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage in GB"
  default     = 20
}

variable "port" {
  type        = number
  description = "Database Port"
  default     = 5432
}

