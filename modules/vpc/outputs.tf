output "vpc_id" {
  value       = aws_vpc.myvpc.id
  description = "displaying id of vpc"
}

output "subnet_ids" {
  value       = [aws_subnet.mysub-1.id, aws_subnet.mysub-2.id]
  description = "output of subnet id"
}