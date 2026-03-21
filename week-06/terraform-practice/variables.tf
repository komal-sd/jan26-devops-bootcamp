# --------------------------------------------------
# variable.tf 
#All variable together
# --------------------------------------------------

variable "aws_region" {
  description = "default region for deploy all resources"
  type        = string
  default     = "us-east-1"

}

variable "vpc_name" {
  description = "vpc name for vpc"
  type        = string
  default     = "devops-bootcamp-vpc"

}
variable "vpc_cidr" {
  description = "cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "environment for dev"
  type        = string
  default     = "dev"
}