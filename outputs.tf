output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2_instance.id
}

output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.ec2_instance.private_ip
}

output "secondary_private_ips" {
  description = "The secondary private IP addresses of the EC2 instance"
  value       = aws_instance.ec2_instance.secondary_private_ips
}
