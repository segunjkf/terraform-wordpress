resource "aws_s3_bucket" "terraform_remote_state" {
  bucket = "kaytheog-wordpress-project"

  force_destroy = true
}

resource "aws_dynamodb_table" "wordpress-terraform-lock" {
  name           = "Wordpress-remote-state"
  read_capacity  = 1
  write_capacity = 1
  billing_mode   = "PROVISIONED"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

