variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet IDs in which to place the EC2 instances"
}

variable "aws_account_id" {
  type        = string
  description = "The AWS account ID"
}

variable "db_user" {
  type        = string
  description = "The username for the database"
  default     = "postgres"
}

variable "db_password" {
  type        = string
  description = "The password for the database"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources"
}

variable "api_host_name" {
  description = "The hostname of the application API"
  type        = string
}
