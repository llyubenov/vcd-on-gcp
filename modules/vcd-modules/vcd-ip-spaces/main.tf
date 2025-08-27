data "vcd_external_network_v2" "provider_gw" {
  name = var.vcd_provider_gateway_name
}

resource "vcd_ip_space" "ip_space" {
  name = var.ip_space_name
  type = var.ip_space_type

  internal_scope = var.internal_scope
  external_scope = var.external_scope

  route_advertisement_enabled            = var.route_advertisement_enabled
  default_firewall_rule_creation_enabled = var.default_firewall_rule_creation_enabled
  default_no_snat_rule_creation_enabled  = var.default_no_snat_rule_creation_enabled
  default_snat_rule_creation_enabled     = var.default_snat_rule_creation_enabled

  dynamic "ip_prefix" {
    for_each = var.ip_prefixes
    content {
        default_quota = ip_prefix.value.default_quota

        prefix {
        first_ip      = ip_prefix.value.first_ip
        prefix_length = ip_prefix.value.prefix_length
        prefix_count  = ip_prefix.value.prefix_count
        }
    }
  }

  dynamic "ip_range" {
    for_each = var.ip_ranges
    content {
        start_address = ip_range.value.start_address
        end_address   = ip_range.value.end_address
    }
  }
}

resource "vcd_ip_space_uplink" "ip_space_uplink" {
  name                = "${var.ip_space_name}-uplink"
  description         = "${var.ip_space_name}-uplink"
  external_network_id = data.vcd_external_network_v2.provider_gw.id
  ip_space_id         = vcd_ip_space.ip_space.id
}
