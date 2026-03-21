# ─────────────────────────────────────────
# variables.tf
# All variables in one place
# ─────────────────────────────────────────

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "devops-bootcamp-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "prefix" {
  description = "prefix for all resources"
  type        = string
  default     = "jan26-bootcamp"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "student-portal"
}
variable "container_port" {
  description = "Port number the container listens on"
  type        = number
  default     = 8000
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "studentportal"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "postgres"
}

variable "image" {
  description = "Docker image URI for the application"
  type        = string
  default     = "nginx:latest"
}