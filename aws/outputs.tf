output "vpc_id" {
  description = "ID of the VPC connected to this project"
  value       = aws_vpc.toy_vpc.id
}
