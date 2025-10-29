#
# Terraform:: terraform-helm-vault-injector
# Plan:: providers.tf
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    helm = {
      version = "~> 3.1"
      source  = "hashicorp/helm"
    }
  }
}
