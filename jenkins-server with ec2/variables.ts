variable "region" {
  default = "ca-central-1"
}

variable "vpc_cidr" {
  description = "VPC Cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "public subnet cidr"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "instance_type" {
  default = "t2.micro"
}
