resource "aws_instance" "name" {
  ami = "ami-0953476d60561c955"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  tags = {
    Name =test
  }
}

 #below examples are for lifecycle meta_arguments 

#   lifecycle {
#     create_before_destroy = true    #this attribute will create the new object first and then destroy the old one
#   }

    lifecycle {
    prevent_destroy = true    #Terraform will error when it attempts to destroy a resource when this is set to true:
     }


  #lifecycle {
    #ignore_changes = [tags,] #This means that Terraform will never update the object but will be able to create or destroy it.
  #}


