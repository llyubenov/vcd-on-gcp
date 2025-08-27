data "vcd_nsxt_manager" "nsxt" {
  name = var.nsxt_manager_name
}

data "vcd_nsxt_segment_ip_discovery_profile" "ip_discovery_profile" {
  count           = var.ip_discovery_profile != "" ? 1 : 0
  name            = var.ip_discovery_profile
  nsxt_manager_id = data.vcd_nsxt_manager.nsxt.id
}

data "vcd_nsxt_segment_mac_discovery_profile" "mac_discovery_profile" {
  count           = var.mac_discovery_profile != "" ? 1 : 0
  name            = var.mac_discovery_profile
  nsxt_manager_id = data.vcd_nsxt_manager.nsxt.id
}

data "vcd_nsxt_segment_spoof_guard_profile" "spoof_guard_profile" {
  count           = var.spoof_guard_profile != "" ? 1 : 0
  name            = var.spoof_guard_profile
  nsxt_manager_id = data.vcd_nsxt_manager.nsxt.id
}

data "vcd_nsxt_segment_qos_profile" "qos_profile" {
  count           = var.qos_profile != "" ? 1 : 0
  name            = var.qos_profile
  nsxt_manager_id = data.vcd_nsxt_manager.nsxt.id
}

data "vcd_nsxt_segment_security_profile" "security_profile" {
  count           = var.security_profile != "" ? 1 : 0
  name            = var.security_profile
  nsxt_manager_id = data.vcd_nsxt_manager.nsxt.id
}

resource "vcd_nsxt_segment_profile_template" "complete" {
  nsxt_manager_id = data.vcd_nsxt_manager.nsxt.id

  name        = var.segment_profile_template_name
  description = var.segment_profile_template_description

  ip_discovery_profile_id     = var.ip_discovery_profile != "" ? data.vcd_nsxt_segment_ip_discovery_profile.ip_discovery_profile[0].id : null
  mac_discovery_profile_id    = var.mac_discovery_profile != "" ? data.vcd_nsxt_segment_mac_discovery_profile.mac_discovery_profile[0].id : null
  spoof_guard_profile_id      = var.spoof_guard_profile != "" ? data.vcd_nsxt_segment_spoof_guard_profile.spoof_guard_profile[0].id : null
  qos_profile_id              = var.qos_profile != "" ? data.vcd_nsxt_segment_qos_profile.qos_profile[0].id : null
  segment_security_profile_id = var.security_profile != "" ? data.vcd_nsxt_segment_security_profile.security_profile[0].id : null
}

