output "ip" {
value = aws_instance.my_web01.public_ip

}

output "ip2" {
value = aws_instance.my_web02.public_ip

}