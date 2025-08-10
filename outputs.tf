output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web.id
}

output "elastic_ip" {
  description = "Elastic IP address"
  value       = aws_eip.web_eip.public_ip
}

output "private_ip" {
  description = "Private IP address"
  value       = aws_instance.web.private_ip
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.web_sg.id
}

output "instance_dns" {
  description = "Public DNS name"
  value       = aws_instance.web.public_dns
}

output "subnet_ids_detected" {
  value = data.aws_subnets.default.ids
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.rds.endpoint
}

output "rds_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.rds.id
}
