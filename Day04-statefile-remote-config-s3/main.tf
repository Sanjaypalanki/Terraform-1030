resource "aws_vpc" "move" {

    cidr_block = "10.0.0.0/16"
  
}

resource "aws_subnet" "move" {

    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.move.id
  
}

resource "aws_subnet" "nest" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.move.id
  
}