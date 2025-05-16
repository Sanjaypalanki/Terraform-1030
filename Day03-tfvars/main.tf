resource "aws_instance" "newinstance" {

    ami = var.ami

    instance_type = var.type
  
}

#resource "aws_s3_bucket" "name" {

    #bucket = var.bucket
  
#}