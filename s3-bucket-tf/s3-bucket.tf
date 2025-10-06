provider "aws" {
  region = "eu-west-3"
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "ramkottaikadu-tfstate" {
  bucket = "ramkottaikadu-jenkins-bucket"
  region = "eu-west-3"
  tags = {
    Name        = "My ews bucket"
    Environment = "dev"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.ramkottaikadu-tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

