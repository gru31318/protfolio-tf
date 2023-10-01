resource "aws_eks_node_group" "nodes_general" {
  cluster_name = aws_eks_cluster.eks.name

  node_group_name = "${var.prefix}-nodeGroup"

  node_role_arn = aws_iam_role.nodes_general_role.arn

  subnet_ids = var.subnet_ids

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 1
  }

  ami_type = var.ami_type

  capacity_type = "ON_DEMAND"

  disk_size = var.disk_size

  force_update_version = false

  instance_types = var.instance_types

  labels = {
    role = "nodes-general-role"
  }

  version = var.cluster_version

  tags = {
    Name = "dressifyWorker"
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_nodes_policy,
    aws_iam_role_policy_attachment.cni_nodes_policy,
    aws_iam_role_policy_attachment.ecr_nodes_policy
  ]
}