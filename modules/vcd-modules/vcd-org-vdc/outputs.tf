output "org_vdc_id" {
  description = "The ID of the created Org VDC"
  value       = vcd_org_vdc.org_vdc.id
}

output "org_vdc_name" {
  description = "The name of the created Org VDC"
  value       = vcd_org_vdc.org_vdc.name
}

output "org_vdc_network_profile_id" {
  description = "The ID of the Org VDC Network Profile"
  value       = vcd_org_vdc_nsxt_network_profile.vdc_network_profile.id
}

output "vdc_catalog_id" {
  description = "The ID of the VDC Catalog (if created)"
  value       = var.create_vdc_catalog ? vcd_catalog.vdc_Catalog[0].id : null
}

output "vdc_catalog_name" {
  description = "The name of the VDC Catalog (if created)"
  value       = var.create_vdc_catalog ? vcd_catalog.vdc_Catalog[0].name : null
}
