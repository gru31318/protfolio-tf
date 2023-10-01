# all
prefix = "dressify"

# vpc
anyone_cidr = "0.0.0.0/0"
cidr_vpc    = "10.0.0.0/16"
sub_count   = 4

# cluster
cluster_version = "1.27"
ami_type        = "AL2_x86_64"
disk_size       = 10
instance_types  = ["t3a.large"]