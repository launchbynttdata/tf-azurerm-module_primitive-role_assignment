# tf-azurerm-module_primitive-role_assignment

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This terraform module provisions a `Role Assignment` resource that assigns an input role to an input Managed Identity (MSI)

## How to Use This Repo

This repo is intended to be used as a template for any new TF module. In some cases, we're able to use our VCS to template for us. In other cases, we aren't.

### Prerequisites

- [asdf](https://github.com/asdf-vm/asdf) used for tool version management
- [make](https://www.gnu.org/software/make/) used for automating various functions of the repo
- [repo](https://android.googlesource.com/tools/repo) used to pull in all components to create the full repo template

### Repo Init

Run the following commands to prep repo and enable all `Makefile` commands to run

```shell
asdf plugin add terraform
asdf plugin add tflint
asdf plugin add golang
asdf plugin add golangci-lint
asdf plugin add nodejs
asdf plugin add opa
asdf plugin add conftest
asdf plugin add pre-commit
asdf plugin add terragrunt

asdf install
```

### Templating

#### Manual Templating

This applies to systems like Azure DevOps and CodeCommit.

We need to clone the repo, rename it, and start a fresh git history to get rid of the `lcaf-skeleton-terraform` history. Below is a loose explanation of how to do this.

``` shell
git clone <this repo's URL>
mv lcaf-skeleton-terraform tf-<whatever it is you're building>
cd tf-<whatever it is you're building>
rm -rf .git
git init
vi .git/HEAD
Change the HEAD to point to `main` instead of `master` and save the `HEAD`
```

#### Remove Educational Material

We need to clear out the example code (different from the boilerplate code). We want to save the repo structure; we don't need the contents. There are `examples`, and `tests` that apply to the boilerplate that we're not going to need as developers of new modules.

Note before you clear these things out, it's useful to actually understand what they are and why they're there. We'll be building our own as we go forward so we need to know what it is we're removing. If this isn't your first module, it's safe to fly through this. If this is your first (or your first several, even), take the time to read the code before you remove it.

```shell
cd path/to/this/repo
rm -rf examples/*
rm -rf README.md
mv TEMPLATED_README.md README.md
```

#### Version Control (VCS) Templating

This applies to systems like GitHub.

TBD

### Repo Setup

#### Overriding Make Behavior

When run, `make` will look for a file called `.lcafenv` in the repository root. This file if present will be included, and it can be used to override variables without altering the [Makefile](Makefile). A few examples of variables that can be substituted are commented out in [the file](.lcafenv).

#### Module Configuration

- You'll need to update [`versions.tf`](./versions.tf) based on your provider needs.

## Explanation of the Skeleton

### Resources and Providers

- Terraform modules define resources that can be instantiated via provider
- Possible providers include but are not limited to `aws`, `azurerm`, and `gcp`
- In this module we generate text resources with the `random` provider

### Module Guidelines

- Each repository should have a default module in its root
  - Should have default values and be instantiable with minimal to no inputs
  - We can think of these default values as the "default example"
- A `Makefile` provides tasks for terraform module development
  - It will clone and cache `caf-components-tf-module` and `caf-components-platform` git repositories when a `make configure` is ran
  - For clearing cached components, it provides a `make clean` command
  - Linter config and all other tasks are defined in `caf-components-tf-module`
- An `examples` folder contains example uses of the default and nested modules
  - There should be at least one example for each nested module
- A `tests` folder contains Go functional tests
  - Make pre-deploy tests that validate terraform plan json where applicable
  - Make post-deploy tests that validate the deployment where applicable
- Provider should be configured by the user, not the module
  - Modules only define what providers/versions are required

### Go Functional Tests

- Modules are how Go manages dependencies
- To initiate a new modules run the command: `go mod init [repo_url]`
  - It is recommended to use the absolute repository url (e.g. github.com/launchbynttdata/lcaf-skeleton-terraform)
- Relative path is highly discouraged in Go, use absolute path to import a package
  - (e.g. `github.com/launchbynttdata/lcaf-skeleton-terraform/[path_to_file]`)
- To update paths or versions run the command: `go get -t ./...`  go will update the dependencies accordingly
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the role assignment. Has to be an unique UUID/GUID. If not specified, one will be generated automatically | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333,<br>    /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup,<br>    or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM,<br>    or /providers/Microsoft.Management/managementGroups/myMG. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_role_definition_name"></a> [role\_definition\_name](#input\_role\_definition\_name) | (Optional) Name of the Role Definition. Changing this forces a new resource to be created. Example: Reader | `string` | `null` | no |
| <a name="input_principal_id"></a> [principal\_id](#input\_principal\_id) | The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_principal_type"></a> [principal\_type](#input\_principal\_type) | (Optional) The type of Principal to assign the Role Definition to. Changing this forces a new resource to be created.<br>    Possible values are User, Group, ServicePrincipal, and Application. Default is ServicePrincipal. | `string` | `"ServicePrincipal"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the role definition |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
