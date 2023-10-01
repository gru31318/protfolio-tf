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

# cluster
variable "cluster_version" {
  type = string
}

variable "ami_type" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "instance_types" {
  type = list(string)
}