provider "aws" {
  region = local.availability_zone
}

resource "aws_dynamodb_table" "orders_table" {
  name         = "Orders"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
  
  attribute {
    name = "status"
    type = "S"
  }
  
  attribute {
    name = "createdAt"
    type = "S"
  }

  global_secondary_index {
    name            = "GSI_Status"
    hash_key        = "status"
    range_key       = "createdAt"
    projection_type = "ALL"
  }
}