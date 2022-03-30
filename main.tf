
###############        AWS Auth        #################

locals {
  kustomization = <<KUSTOMIZATION
apiVersion: v1
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
  provisioner "local-exec" {
    command = "git add . && git commit -m 'pushed from terraform' && git push origin -u main  && rm ./kustomization.yaml"
  }
}
