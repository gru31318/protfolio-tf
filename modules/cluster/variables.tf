# all
variable "prefix" {
  type = string
}

# cluster
variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

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