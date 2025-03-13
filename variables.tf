variable subnet_ids {
  type = list(string)
  description = "The list of subnet IDs in which to place the EC2 instances"
  default =  [
      "subnet-037aa55c30f5325b3",
      "subnet-029aa88888b749374",
      "subnet-0323144c57402667d"
    ]
}

variable lab_role_arn {
  type = string
  description = "The ARN of the role to assume for the lab"
  default = ""
}

variable "db_password" {
  type = string
  description = "The password for the database"
}