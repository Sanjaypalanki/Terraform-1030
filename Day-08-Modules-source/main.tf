#module "dev" {
 #   source = "../Day03-tfvars"
  #  ami = "ami-0953476d60561c955"
   # type = "t2.medium"
#}

resource "aws_instance" "this" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    key_name = var.key_name
  
}