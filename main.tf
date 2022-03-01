#
# Terraform:: terraform-helm-vault-injector
# Plan:: main.tf
#

resource "helm_release" "vault_injector" {
  name       = var.name
  repository = var.repository
  chart      = var.chart
  version    = var.chart_version
  namespace  = var.namespace

  values = [templatefile("${path.module}/files/vault-values.yaml", {
    agent_image_repository = var.agent_image_repository
    agent_image_tag        = var.agent_image_tag
    image_repository       = var.image_repository
    image_tag              = var.image_tag
    log_format             = var.log_format
    log_level              = var.log_level
    node_selectors         = var.node_selectors
    priority_class_name    = var.priority_class_name
    revoke_on_shutdown     = tostring(var.revoke_on_shutdown)
    tolerations            = var.tolerations
    vault_addr             = var.vault_addr
    vault_mount            = var.vault_mount
  })]
}
