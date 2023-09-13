# add a variable to pass in the resource group name
variable "resource_group_name" {
    description = "value of the resource group name"            
     type = string 
    }       

variable "region" {
    description = "value of the azure region to put the resources"
    type = string
    }   
