###################
# terraform Provider install
###################
terraform {
  required_version = ">= 0.13"
  #required for using terraform with esxi
  required_providers {
    esxi = {
      source = "registry.terraform.io/josenk/esxi"
      #
      # For more information, see the provider source documentation:
      # https://github.com/josenk/terraform-provider-esxi
      # https://registry.terraform.io/providers/josenk/esxi
    }
  }
}