variable "region" {
  default = "ca-central-1"
}

variable "vpc_cidr" {
  description = "VPC Cidr"
  type        = string
  default     = "192.68.0.0/16"
}


variable "private_subnets" {
  description = "private subnet"
  type        = list(string)
  default     = ["192.68.1.0/24", "192.68.7.0/24", "192.68.3.0/24"]
}

variable "public_subnets" {
  description = "public subnet cidr"
  type        = list(string)
  default     = ["192.68.4.0/24", "192.68.5.0/24", "192.68.6.0/24"]
}


variable "instance_type" {
  default = "t2.micro"
}
