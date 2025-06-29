# eks roles
resource "aws_iam_role" "eks_cluster" {
  name = "${var.prefix}-eksClusterRole"

  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  role = aws_iam_role.eks_cluster.name
}
resource "aws_iam_role_policy_attachment" "eks_vpc_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"

  role = aws_iam_role.eks_cluster.name
}

# node group roles
resource "aws_iam_role" "nodes_general_role" {
  name = "${var.prefix}-eksNodeGroupGen"

  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  POLICY
}

resource "aws_iam_role_policy_attachment" "worker_nodes_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  role = aws_iam_role.nodes_general_role.name
}
resource "aws_iam_role_policy_attachment" "cni_nodes_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  role = aws_iam_role.nodes_general_role.name
}
resource "aws_iam_role_policy_attachment" "ecr_nodes_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  role = aws_iam_role.nodes_general_role.name
}
resource "aws_iam_role_policy_attachment" "ec2_nodes_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"

  role = aws_iam_role.nodes_general_role.name
}