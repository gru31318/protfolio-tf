data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks.id
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.eks.id
}


output "cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "cluster_token" {
  value = data.aws_eks_cluster_auth.cluster_auth.token
}

output "cluster_ca_certificate" {
  value = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}