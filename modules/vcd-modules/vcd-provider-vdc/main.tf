data "vcd_vcenter" "vcenter" {
  name = var.vcenter_name
}

data "vcd_resource_pool" "resource_pool" {
  name       = var.vcenter_resource_pool_name
  vcenter_id = data.vcd_vcenter.vcenter.id
}

data "vcd_nsxt_manager" "nsxt_manager" {
  name = var.nsxt_manager_name
}

resource "vcd_network_pool" "network_pool" {
  name                = var.network_pool_name
  description         = var.network_pool_description
  network_provider_id = data.vcd_nsxt_manager.nsxt_manager.id
  type                = "GENEVE"

  backing {
    transport_zone {
      name = var.transport_zone_name
    }
  }
}

resource "vcd_provider_vdc" "pvdc" {
  name                               = var.pvdc_name
  description                        = "Provider VDC for ${var.vcenter_name} vCenter."
  is_enabled                         = true
  vcenter_id                         = data.vcd_vcenter.vcenter.id
  nsxt_manager_id                    = data.vcd_nsxt_manager.nsxt_manager.id
  network_pool_ids                   = [vcd_network_pool.network_pool.id]
  resource_pool_ids                  = [data.vcd_resource_pool.resource_pool.id]
  storage_profile_names              = var.storage_profile_names
  highest_supported_hardware_version = data.vcd_resource_pool.resource_pool.hardware_version
}

