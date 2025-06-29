# all
variable "prefix" {
  type = string
}

# vpc
variable "anyone_cidr" {
  type = string
}

variable "cidr_vpc" {
  type = string
}

variable "sub_count" {
  description = "Number of subnets to create"
  type        = number
}

# data for az
data "aws_availability_zones" "available" {
  state = "available"
}