module "dev" {
  
  source = "../Day-08-Modules-source"
  ami_id = "ami-0953476d60561c955"
  aws_region = "us-east-1a"
  instance_type = "t2.micro"
}