
###############        AWS Auth        #################

locals {
  kustomization = <<KUSTOMIZATION
apiVersion: v1/batch
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: somearn
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
KUSTOMIZATION
}

resource "local_file" "foo" {
  content  = local.kustomization
  filename = "kustomization.yaml"
}