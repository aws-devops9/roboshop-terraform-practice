variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "common_tags" { # Parse this variable in main.tf - mandotory
  default = {
    Project = "roboshop"
    Environment = "dev"
    Terraform = "true"
  }
}

variable "vpc_tags" {
  type = map
  default = {}
}

variable "project_name" { # Parse this variable in main.tf - mandotory
  type = string
  default = "roboshop"
}

variable "environment" { # Parse this variable in main.tf - mandotory
  type = string
  default = "dev"
}

variable "public_subnets_cidr" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnets_cidr" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "is_peering_required" {
  type = bool
  default = "true"
}