resource "kubectl_manifest" "mysql_secrets" {
  yaml_body = <<YAML
    apiVersion: v1
    kind: Secret
    metadata:
      name: mysql-secrets
      namespace: default
    type: Opaque
    data:
      app-db-user: ${base64encode(jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["dbuser"])}
      mysql-root-password: ${base64encode(jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["rootpass"])}
      mysql-replication-password: ${base64encode(jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["dbpass"])}
      mysql-password: ${base64encode(jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["dbpass"])}
  YAML
}

# resource "kubectl_manifest" "argo_apps" {
#   yaml_body = <<YAML
#     apiVersion: argoproj.io/v1alpha1
#     kind: Application
#     metadata:
#       name: argo-apps
#       namespace: argocd
#     spec:
#       project: default 

#       source:
#         repoURL: git@github.com:gru31318/protfolio-gitops.git
#         targetRevision: HEAD
#         path: apps
#       destination:
#         server: https://kubernetes.default.svc
#         namespace: default

#       syncPolicy:
#         syncOptions:
#           - CreateNamespace=true

#         automated:
#           selfHeal: true
#           prune: true
#   YAML 

#   depends_on = [ 
#     helm_release.argocd
#    ]
# }