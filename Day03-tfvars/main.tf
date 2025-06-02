resource "aws_instance" "newinstance" {

    ami = var.ami

    instance_type = var.type

    availability_zone = "us-east-1a"
  
}

#resource "aws_s3_bucket" "name" {

    #bucket = var.bucket
  
#}