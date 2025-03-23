variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet IDs in which to place the EC2 instances"
  default = [
    "subnet-055f45d93abff35b9",
    "subnet-0fcd5d1f542a08584"
  ]
}

variable "aws_account_id" {
  type        = string
  description = "The AWS account ID"
  default     = "772797387444"
}

variable "lab_role_arn" {
  type        = string
  description = "The ARN of the role to assume for the lab"
  default     = "arn:aws:iam::772797387444:role/LabRole"
}

variable "db_password" {
  type        = string
  description = "The password for the database"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources"
}
