#
# Terraform:: terraform-helm-vault-injector
# Plan:: providers.tf
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    helm = {
      version = "~> 2.4"
      source  = "hashicorp/helm"
    }
  }
}
