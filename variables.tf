// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "name" {
  description = "Name of the role assignment. Has to be an unique UUID/GUID. If not specified, one will be generated automatically"
  type        = string
  default     = null
}

variable "scope" {
  description = <<EOT
    The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333,
    /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup,
    or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM,
    or /providers/Microsoft.Management/managementGroups/myMG. Changing this forces a new resource to be created.
  EOT
  type        = string
}

variable "role_definition_name" {
  description = "(Optional) Name of the Role Definition. Changing this forces a new resource to be created. Example: Reader"
  type        = string
  default     = null
}

variable "principal_id" {
  description = "The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created."
  type        = string
}

variable "principal_type" {
  description = <<EOT
    (Optional) The type of Principal to assign the Role Definition to. Changing this forces a new resource to be created.
    Possible values are User, Group, ServicePrincipal, and Application. Default is User.
  EOT
  type        = string
  default     = "User"
}
