
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
  # provisioner "local-exec" {
  #   command     = " git config --global user.email m.proud78.com && git config --global user.name kebzur && git add . && git commit -m 'pushed from terraform' && git push origin -u main -f"
  #   interpreter = []
  # }
}
