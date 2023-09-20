# add a variable to pass in the resource group name
variable "resource_group_name" {
  description = "value of the resource group name"
  type        = string
  default     = "private-resolver-prototype"
}
# add a variable to pass in the azure region
variable "region" {
  description = "value of the azure region to put the resources"
  type        = string
  default     = "centralus"
}


# add a variable for the login username
variable "vm_username" {
  description = "value of the ssh username"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "value of the ssh public key"
  type        = string
}

variable "private_dns_zone_name" {
  description = "name of the private zone"
  type        = string
  default     = "bep.hhs.gov"
}





