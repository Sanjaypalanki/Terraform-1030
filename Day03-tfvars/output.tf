output "ip" {
    value = aws_instance.newinstance.public_ip
  
}
output "privateip" {
    value = aws_instance.newinstance.subnet_id
    sensitive = true
  
}

