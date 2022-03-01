<!--- BEGIN_TF_DOCS --->
<!-- markdownlint-disable MD024 MD033 -->
# terraform-helm-vault-injector

Terraform module to deploy HashiCorp Vault Agent Injector via Helm

## Requirements

The following requirements are needed by this module:

- terraform (~> 1.0)

- helm (~> 2.4)

## Required Inputs

The following input variables are required:

### vault\_addr

Description: Address of a running Vault cluster that the agent will communicate with

Type: `string`

### vault\_mount

Description: The Kubernetes auth mount path on Vault

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### agent\_image\_repository

Description: Vault Agent Docker image repository

Type: `string`

Default: `"vault"`

### agent\_image\_tag

Description: Vault Agent Docker image tag. Versions can be found [here](https://github.com/hashicorp/vault)

Type: `string`

Default: `"1.9.3"`

### chart

Description: Specifies the version of the Vault Helm chart to use to install the Vault Agent

Type: `string`

Default: `"vault"`

### chart\_version

Description: Helm chart version. Versions can be found [here](https://github.com/hashicorp/vault-helm)

Type: `string`

Default: `"0.19.0"`

### image\_repository

Description: Vault Docker image repository

Type: `string`

Default: `"hashicorp/vault-k8s"`

### image\_tag

Description: Vault + Kubernetes image tag. Versions can be found [here](https://github.com/hashicorp/vault-k8s)

Type: `string`

Default: `"0.14.2"`

### log\_format

Description: Log format. [json, standard]

Type: `string`

Default: `"json"`

### log\_level

Description: Log level: [trace, debug, info, warn, error]

Type: `string`

Default: `"info"`

### name

Description: Vault Agent Injector base name. Automatically appends `-agent-injector` to this value.

Type: `string`

Default: `"vault"`

### namespace

Description: Kubernetes namespace into which the agent will be installed

Type: `string`

Default: `"vault"`

### node\_selectors

Description: In order for the Vault pods to be scheduled on a node, the node must have all of the specified key-value pairs as labels

Type: `map(string)`

Default: `null`

### priority\_class\_name

Description: Priority class name for injector pods

Type: `string`

Default: `""`

### repository

Description: Helm chart repository URL

Type: `string`

Default: `"https://helm.releases.hashicorp.com"`

### revoke\_on\_shutdown

Description: Configures all Vault Agent sidecars to revoke their token when shutting down.

Type: `bool`

Default: `true`

### tolerations

Description: List of taints that the Vault pods should tolerate

Type:

```hcl
list(object({
    key    = string
    value  = string
    effect = string
  }))
```

Default: `null`

## Outputs

No outputs.

## Contributing

Contributions are always welcome. Please consult our [CONTRIBUTING.md](CONTRIBUTING.md) file for more information on how to submit quality contributions.

## License & Authors

Author: Brian Menges (@mengesb)

```text
   Copyright 2022 Brian Menges

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```

<!--- END_TF_DOCS --->
