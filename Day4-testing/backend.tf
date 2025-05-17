terraform {
  backend "s3" {
    bucket = "bucketfors31234cd"
    key    = "day-1/terraform.tfstate"
    region = "us-east-1"
  }
}