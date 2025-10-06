output "ip_space_id" {
  description = "The ID of the created IP Space"
  value       = vcd_ip_space.ip_space.id
}

output "ip_space_name" {
  description = "The name of the created IP Space"
  value       = vcd_ip_space.ip_space.name
}

output "ip_space_uplink_id" {
  description = "The ID of the IP Space Uplink"
  value       = vcd_ip_space_uplink.ip_space_uplink.id
}

output "ip_space_uplink_name" {
  description = "The name of the IP Space Uplink"
  value       = vcd_ip_space_uplink.ip_space_uplink.name
}

output "external_network_id" {
  description = "The ID of the External Network"
  value       = data.vcd_external_network_v2.provider_gw.id
}

output "external_network_name" {
  description = "The name of the External Network"
  value       = data.vcd_external_network_v2.provider_gw.name
}
