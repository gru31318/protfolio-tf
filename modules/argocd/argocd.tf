data "aws_secretsmanager_secret" "secret_arn" {
  arn = "arn:aws:secretsmanager:eu-west-2:644435390668:secret:nachman-secrets-zvIvPu"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secret_arn.id
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.36.0"
  namespace        = "argocd"
  create_namespace = true


  set {
    name  = "configs.secret.argocdServerAdminPassword"
    value = "$2a$10$aaXHng.wih6Z1uUex1P.s.dkNH1BNRj9Cq73MVDvbV.hdCMJwjPpe"
  }

  set {
    name  = "configs.credentialTemplates.ssh-creds.url"
    value = "git@github.com:gru31318/protfolio-gitops.git"
  }

  set {
    name  = "configs.credentialTemplates.ssh-creds.sshPrivateKey"
    value = base64decode(jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["sshkey"])
  }
}