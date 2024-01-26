resource "aws_dynamodb_table" "my_terrafrom_table" {
  name         = "my_terrafrom_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"
  attribute {
    name = "ID"
    type = "S"
  }
  tags = {
    Name = "my terrafrom table"
  }

}

resource "aws_dynamodb_table_item" "my_terrafrom_table_item" {
  for_each   = local.tf_data
  table_name = aws_dynamodb_table.my_terrafrom_table.name
  hash_key   = "ID"
  item       = jsonencode(each.value)

}