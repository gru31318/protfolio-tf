# all
variable "prefix" {
  type = string
}

# cluster
variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}