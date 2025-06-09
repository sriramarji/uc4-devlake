variable "name" {
  type        = string
  default     = "devlake-alb"
  description = "load balancer name"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

/*variable "target_group_a_arn" {
  description = "Target group ARN for instance A."
  type        = string
}*/

variable "subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

variable "ec2_instance_id" {
  description = "EC2 instance ID to attach to the target group"
  type        = string
}