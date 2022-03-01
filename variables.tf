#
# Terraform:: terraform-helm-vault-injector
# Plan:: variables.tf
#

variable "name" {
  sensitive   = false
  type        = string
  description = "Vault Agent Injector base name. Automatically appends `-agent-injector` to this value."
  default     = "vault"

  validation {
    condition     = length("${var.name}-agent-injector") < 64
    error_message = "Name must contain at most 48 characters, as `-agent-injector` (15 characters) is automatically appended for a maximum length of 63 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "Name must contain only lowercase alphanumeric characters or '-'."
  }

  validation {
    condition     = can(regex("^[a-z0-9]", var.name))
    error_message = "Name must start with an alphanumeric character."
  }

  validation {
    condition     = can(regex("[a-z0-9]$", var.name))
    error_message = "Name must end with an alphanumeric character."
  }
}

variable "repository" {
  sensitive   = false
  type        = string
  description = "Helm chart repository URL"
  default     = "https://helm.releases.hashicorp.com"

  validation {
    condition     = can(regex("^http(s)?://", var.repository))
    error_message = "Repository URL must begin with 'http://' or 'https://'."
  }
}

variable "chart" {
  sensitive   = false
  type        = string
  description = "Specifies the version of the Vault Helm chart to use to install the Vault Agent"
  default     = "vault"
}

variable "chart_version" {
  sensitive   = false
  type        = string
  description = "Helm chart version. Versions can be found here: https://github.com/hashicorp/vault-helm"
  default     = "0.19.0"

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.chart_version))
    error_message = "Value must of the format '#.#.#'."
  }
}

variable "namespace" {
  sensitive   = false
  type        = string
  description = "Kubernetes namespace into which the agent will be installed"
  default     = "vault"

  validation {
    condition     = length(var.namespace) < 64
    error_message = "Namespace must contain at most 63 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.namespace))
    error_message = "Namespace must contain only lowercase alphanumeric characters or '-'."
  }

  validation {
    condition     = can(regex("^[a-z0-9]", var.namespace))
    error_message = "Namespace must start with an alphanumeric character."
  }

  validation {
    condition     = can(regex("[a-z0-9]$", var.namespace))
    error_message = "Namespace must end with an alphanumeric character."
  }
}

variable "vault_addr" {
  sensitive   = false
  type        = string
  description = "Address of a running Vault cluster that the agent will communicate with"

  validation {
    condition     = can(regex("^http(s)?://", var.vault_addr))
    error_message = "Vault URL must begin with 'http://' or 'https://'."
  }
}

variable "image_repository" {
  sensitive   = false
  type        = string
  description = "Vault Docker image repository"
  default     = "hashicorp/vault-k8s"
}

variable "image_tag" {
  sensitive   = false
  type        = string
  description = "Vault + Kubernetes image tag. Versions can be found here: https://github.com/hashicorp/vault-k8s"
  default     = "0.14.2"

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.image_tag))
    error_message = "Value must of the format '#.#.#'."
  }
}

variable "agent_image_repository" {
  sensitive   = false
  type        = string
  description = "Vault Agent Docker image repository"
  default     = "vault"
}

variable "agent_image_tag" {
  sensitive   = false
  type        = string
  description = "Vault Agent Docker image tag. Versions can be found here: https://github.com/hashicorp/vault"
  default     = "1.9.3"

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.agent_image_tag))
    error_message = "Value must of the format '#.#.#'."
  }
}

variable "vault_mount" {
  sensitive   = false
  type        = string
  description = "The Kubernetes auth mount path on Vault"

  validation {
    condition     = split("/", var.vault_mount)[0] != "auth"
    error_message = "Vault mount assumes the starting path of `auth/`. Specify the mount without `auth/`."
  }
}

variable "log_level" {
  sensitive   = false
  type        = string
  description = "Log level: [trace, debug, info, warn, error]"
  default     = "info"

  validation {
    condition     = contains(["trace", "debug", "info", "warn", "error"], var.log_level)
    error_message = "Log level must be one of the following: `trace`, `debug`, `info`, `warn`, or `error`."
  }
}

variable "log_format" {
  sensitive   = false
  type        = string
  description = "Log format. [json, standard]"
  default     = "json"

  validation {
    condition     = contains(["json", "standard"], var.log_format)
    error_message = "Log format must be one of the following, `json` or `standard`."
  }
}

variable "revoke_on_shutdown" {
  sensitive   = false
  type        = bool
  description = "Configures all Vault Agent sidecars to revoke their token when shutting down."
  default     = true

  validation {
    condition     = contains([true, false], var.revoke_on_shutdown)
    error_message = "Revoke on shutdown must be a boolean, `true` or `false`."
  }
}

variable "node_selectors" {
  sensitive   = false
  type        = map(string)
  description = "In order for the Vault pods to be scheduled on a node, the node must have all of the specified key-value pairs as labels"
  default     = null
}

variable "tolerations" {
  sensitive = false
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  description = "List of taints that the Vault pods should tolerate"
  default     = null
}

variable "priority_class_name" {
  sensitive   = false
  type        = string
  description = "Priority class name for injector pods"
  default     = ""

  validation {
    condition     = length(var.priority_class_name) < 64
    error_message = "Priority class name must contain at most 63."
  }

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.priority_class_name))
    error_message = "Priority class name must contain only lowercase alphanumeric characters or '-'."
  }

  validation {
    condition     = can(regex("^[a-z0-9]", var.priority_class_name))
    error_message = "Priority class name must start with an alphanumeric character."
  }

  validation {
    condition     = can(regex("[a-z0-9]$", var.priority_class_name))
    error_message = "Priority class name must end with an alphanumeric character."
  }
}
