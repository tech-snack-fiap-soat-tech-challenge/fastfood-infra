variable "queue_max_receive_count" {
  description = "Maximum number of times a message can be received before being sent to the dead letter queue"
  type        = number
  default     = 4
}

variable "queue_visibility_timeout" {
  description = "The duration (in seconds) that the received messages are hidden from subsequent retrieve requests after being retrieved by a ReceiveMessage request"
  type        = number
  default     = 60
}