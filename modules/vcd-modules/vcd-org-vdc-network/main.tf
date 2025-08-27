data "vcd_external_network_v2" "provider_gw" {
  name = var.provider_gateway_name
}

data "vcd_org" "org" {
  name = var.org_name
}

data "vcd_org_vdc" "vdc" {
  name = var.vdc_name
  org  = var.org_name
}

data "vcd_ip_space" "ip_space" {
  name = var.ip_space_name
}

data "vcd_nsxt_segment_profile_template" "segment_profile_template" {
  count  = var.segment_profile_template_name != "" ? 1 : 0
  name   = var.segment_profile_template_name
}

resource "vcd_nsxt_edgegateway" "nsxt-edge" {
  org                 = var.org_name
  owner_id            = data.vcd_org_vdc.vdc.id
  name                = var.edge_gw_name
  external_network_id = data.vcd_external_network_v2.provider_gw.id
}

resource "vcd_ip_space_ip_allocation" "public-ip-prefix" {
  org_id        = data.vcd_org.org.id
  ip_space_id   = data.vcd_ip_space.ip_space.id
  type          = var.ip_space_allocation_type
  prefix_length = var.ip_space_prefix_lenght

  depends_on = [vcd_nsxt_edgegateway.nsxt-edge]
}

resource "vcd_network_routed_v2" "vdc_network" {
  org             = var.org_name
  name            = var.vdc_network_name
  edge_gateway_id = vcd_nsxt_edgegateway.nsxt-edge.id
  gateway         = cidrhost(vcd_ip_space_ip_allocation.public-ip-prefix.ip_address, 1)
  prefix_length   = split("/", vcd_ip_space_ip_allocation.public-ip-prefix.ip_address)[1]
  guest_vlan_allowed = var.allow_guest_vlan

  static_ip_pool {
    start_address = cidrhost(vcd_ip_space_ip_allocation.public-ip-prefix.ip_address, 2)
    end_address   = cidrhost(vcd_ip_space_ip_allocation.public-ip-prefix.ip_address, 509)
  }
}

resource "vcd_nsxt_network_segment_profile" "vdc_net_segment_profile" {
  count          = var.segment_profile_template_name != "" ? 1 : 0
  org            = var.org_name
  org_network_id = vcd_network_routed_v2.vdc_network.id

  segment_profile_template_id = data.vcd_nsxt_segment_profile_template.segment_profile_template[0].id
}

resource "vcd_nsxt_network_dhcp" "pools" {
  count          = var.dhcp_enabled == true ? 1 : 0
  org_network_id = vcd_network_routed_v2.vdc_network.id

  pool {
    start_address = cidrhost(vcd_ip_space_ip_allocation.public-ip-prefix.ip_address, 20)
    end_address   = cidrhost(vcd_ip_space_ip_allocation.public-ip-prefix.ip_address, 40)
  }
}
