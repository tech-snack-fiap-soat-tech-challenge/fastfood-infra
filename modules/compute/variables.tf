variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet IDs in which to place the EC2 instances"
}

variable "node_role_arn" {
  type        = string
  description = "ARN of the EKS Node Group Role"
}