output "vpc_id" {
  value       = aws_vpc.AM-vpc.id 
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = values(aws_subnet.AM-private-subnet)[*].id 
  description = "Public Subnet ID"
}

output "private_subnet_ids" {
  value       = values(aws_subnet.AM-private-subnet)[*].id 
  description = "Private Subnet ID"
}

output "DB_subnet_ids" {
  value       = values(aws_subnet.AM-DB-subnet)[*].id 
  description = "DB Subnet ID"
}