resource "aws_eks_cluster" "eks" {
  name = "${var.prefix}-eks"

  role_arn = aws_iam_role.eks_cluster.arn

  version = "1.27"

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = [ 
        aws_subnet.subnet_1.id,
        aws_subnet.subnet_2.id
     ]
  }

  depends_on = [ 
    aws_iam_role_policy_attachment.eks_cluster_policy
   ]
}