variable "prefix" {
  type = string
}

variable "anyone_cidr" {
  type = string
}

variable "cidr_vpc" {
  type = string
}

variable "cidr_subnets" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}