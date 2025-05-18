resource "aws_sqs_queue" "order_queue" {
  name                        = "order-created.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  visibility_timeout_seconds  = local.queue_visibility_timeout

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.order_queue_deadletter.arn
    maxReceiveCount     = local.queue_max_receive_count
  })
}

resource "aws_sqs_queue" "order_queue_deadletter" {
  name                        = "order-created-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue" "product_queue" {
  name                        = "payment-completed.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  visibility_timeout_seconds  = local.queue_visibility_timeout

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.product_queue_deadletter.arn
    maxReceiveCount     = local.queue_max_receive_count
  })
}

resource "aws_sqs_queue" "product_queue_deadletter" {
  name                        = "payment-completed-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}