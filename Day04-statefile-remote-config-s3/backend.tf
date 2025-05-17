terraform {
  backend "s3" {
    bucket = "bucketfors31234cd"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
