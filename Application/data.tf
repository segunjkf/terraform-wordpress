data "terraform_remote_state" "wordpress-network-level" {
  backend = "s3"

  config = {
    bucket = "kaytheog-wordpress-project"
    key    = "wordpress-network-level.tfstate"
    region = "eu-west-1"
  }
}

