output "provider_vdc_id" {
  description = "The ID of the created Provider VDC"
  value       = vcd_provider_vdc.pvdc.id
}

output "provider_vdc_name" {
  description = "The name of the created Provider VDC"
  value       = vcd_provider_vdc.pvdc.name
}

output "network_pool_id" {
  description = "The ID of the created Network Pool"
  value       = vcd_network_pool.network_pool.id
}

output "network_pool_name" {
  description = "The name of the created Network Pool"
  value       = vcd_network_pool.network_pool.name
}

output "vcenter_id" {
  description = "The ID of the vCenter"
  value       = data.vcd_vcenter.vcenter.id
}

output "nsxt_manager_id" {
  description = "The ID of the NSX-T Manager"
  value       = data.vcd_nsxt_manager.nsxt_manager.id
}

output "resource_pool_id" {
  description = "The ID of the Resource Pool"
  value       = data.vcd_resource_pool.resource_pool.id
}
