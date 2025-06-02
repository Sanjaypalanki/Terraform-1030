# VPC

resource "aws_vpc" "dev" {

    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "testvpc"
    }
  
}

# IG and attach to VPC 

resource "aws_internet_gateway" "name" {

    vpc_id = aws_vpc.dev.id
  
}

# Subnets

resource "aws_subnet" "publicsub" {

    cidr_block = "10.0.0.0/24"

    vpc_id = aws_vpc.dev.id

    availability_zone = "us-east-1a"
  
}

resource "aws_subnet" "privatesub" {

    cidr_block = "10.0.1.0/24"

    vpc_id = aws_vpc.dev.id
  
}


# RT , edit routes

resource "aws_route_table" "name" {

    vpc_id = aws_vpc.dev.id

    route  {

        cidr_block = "0.0.0.0/0"

        gateway_id = aws_internet_gateway.name.id

    }
  
}


# subnet association

resource "aws_route_table_association" "name" {



    subnet_id = aws_subnet.publicsub.id

    route_table_id = aws_route_table.name.id
  
}

# create SG

resource "aws_security_group" "allow_tls" {
    name = "allow_tls"
    vpc_id = aws_vpc.dev.id
    tags = {
      Name = "test_sg"
    }

  ingress {

    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks= ["0.0.0.0/0"]

  }

  ingress {

    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = "0"
    to_port = "0" 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 
  }
}


# Launch Instance

resource "aws_instance" "name" {
    ami = "ami-0953476d60561c955"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.publicsub.id
    associate_public_ip_address = true
    availability_zone = "us-east-1a"
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
}
