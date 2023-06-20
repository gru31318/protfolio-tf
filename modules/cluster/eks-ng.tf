resource "aws_eks_node_group" "nodes_general" {
  cluster_name = aws_eks_cluster.eks.name

  node_group_name = "${var.prefix}-nodeGroup"

  node_role_arn = aws_iam_role.nodes_general_role.arn

  subnet_ids = var.subnet_ids

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 1
  }

  ami_type = "AL2_x86_64"

  capacity_type = "ON_DEMAND"

  disk_size = 10

  force_update_version = false

  instance_types = ["t3a.large"]

  labels = {
    role = "nodes-general-role"
  }

  version = "1.27"

  tags = {
    Name = "dressifyWorker"
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_nodes_policy,
    aws_iam_role_policy_attachment.cni_nodes_policy,
    aws_iam_role_policy_attachment.ecr_nodes_policy
  ]


}