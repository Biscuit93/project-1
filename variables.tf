variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name."
}

variable "users" {
  default     = ["jaldeep", "david", "jaspal", "yi"]
  description = "Names of users to be created on AWS"
}

variable "num_of_buckets" {
  default     = 2
  description = "Number of buckets to be created on AWS"
  validation {
    condition     = var.num_of_buckets > 0
    error_message = "The number of buckets should be greater than zero."
  }
}

variable "virtual_machine_name_prefix" {
  default     = "vm"
  description = "Prefix of the virtual machine name."
}

variable "default_password" {
  default     = "D3f4Ul7_P4s5W0rD"
  description = "Default password for everything."
  sensitive   = true
}

variable "admin_name" {
  default     = "aferski"
  description = "My name for accounts."
}

variable "hostname" {
  default     = "testmachine"
  description = "Hostname for test virtual machine."
}

variable "environment" {
  default = "demonstration"
}

variable "nametag" {
  default = "t22dev01"
}

variable "osdiskname" {
  default = "storagedisk01"
}