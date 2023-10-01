resource "aws_eks_cluster" "eks" {
  name = "dressify-eks"

  role_arn = aws_iam_role.eks_cluster.arn

  version = var.cluster_version

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids              = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

resource "aws_eks_addon" "eks_addon" {
  cluster_name  = aws_eks_cluster.eks.name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = "v1.19.0-eksbuild.1"

  resolve_conflicts = "OVERWRITE"

  depends_on = [
    aws_eks_node_group.nodes_general
  ]
}