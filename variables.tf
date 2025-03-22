variable lab_role_arn {
  type = string
  description = "The ARN of the role to assume for the lab"
  default = ""
}

variable compute_subnet_ids {
  type = list(string)
  description = "The list of subnet IDs in which to place the EC2 instances"
}

variable database_subnet_ids {
  type = list(string)
  description = "The list of subnet IDs in which to place the Database instances"
}

variable "db_password" {
  type = string
  description = "The password for the database"
}