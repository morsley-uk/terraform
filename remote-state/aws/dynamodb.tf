resource "aws_dynamodb_table" "terraform_statelock" {
    name           = var.aws_terraform_table
    read_capacity  = 20
    write_capacity = 20
    hash_key       = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}