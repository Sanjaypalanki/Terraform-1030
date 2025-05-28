resource "aws_instance" "name" {

    ami = "ami-0953476d60561c955"

   instance_type = "t2.micro"
  
}

resource "aws_vpc" "name" {

    cidr_block = "10.0.0.0/16"

    depends_on = [ aws_instance.name ]
  
}