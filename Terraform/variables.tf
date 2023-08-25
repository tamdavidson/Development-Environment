#########################################
#  ESXI Provider host/login details
#########################################
#
# Reference: https://www.terraform.io/language/values/variables
#
variable "esxi_hostname" {
  description   = "ESXI server host name."
  default       = ""
}

variable "esxi_hostport" {
  description   = "ESXI server port."
  default       = ""
}

variable "esxi_hostssl" {
  description   = "ESXI server SSL port."
  default       = ""
}

variable "esxi_username" {
  description   = "ESXI server user name."
  default       = ""
}

variable "esxi_password" { # Unspecified will prompt
  description   = "ESXI server password."
  sensitive     = true
  default       = ""
}

variable "vm_name_prefix" {
  description = "prefix of each virtual machine"
  default = "testing"
  
}

variable "win10_count" {
  description = "number of windows 10 OS VM to create"
  default = 6
}

variable "win2022_count" {
  description = "number of windows server 2022 OS VM to create"
  default = 1
}