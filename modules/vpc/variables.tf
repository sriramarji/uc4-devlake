variable "vpc_cidr" {
  type        = string
  default     = "192.168.0.0/16"
  description = "VPC CIDR"
}

variable "sub_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24", "192.168.20.0/24"]
  description = "subnet CIDR"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "specify region"
}

variable "subnet_ids" {
  type = list(string)
}
