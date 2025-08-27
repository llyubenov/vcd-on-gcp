terraform {
  required_version = ">= 1.9.6"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = ">= 3.14.1"
    }
  }
}
