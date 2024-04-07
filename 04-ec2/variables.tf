variable "common_tags" {
  default = {
    Terraform   = "true"
    Environment = "dev"
    Project = "roboshop"
    }
}

variable "mongodb_tags" {
  default = {}
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}