variable "subnet_ids" {
  type = list(string)
  description = "The list of subnet IDs in which to place the EC2 instances"
}

variable "db_password" {
  type = string
  description = "The password for the database"
}