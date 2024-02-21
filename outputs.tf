output "instance_ip_0" {
  value = aws_instance.my_instance[0].public_ip
}

output "instance_ip_2" {
  value = aws_instance.my_instance[1].public_ip
}