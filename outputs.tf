output "instance_public_ip" {
  description = "Public IP of the EC2 instance"

  value = aws_instance.webserver.public_ip
}

output "instance_public_dns" {
  description = "Public DNS"

  value = aws_instance.webserver.public_dns
}

output "ssh_command" {
  description = "SSH command"

  value = "ssh -i ssh-key/terraform-key ubuntu@${aws_instance.webserver.public_ip}"
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}