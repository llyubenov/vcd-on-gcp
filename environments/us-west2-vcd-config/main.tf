provider "vcd" {
  user                 = var.sys_admin_user
  password             = var.sys_admin_password_b64
  auth_type            = "integrated"
  org                  = "System"
  url                  = var.vcd_url
  allow_unverified_ssl = var.vcd_allow_unverified_ssl
}

#### Create VLP system administrator account
resource "random_password" "sys_admin_pass" {
  length                = 16
  special               = true
  override_special      = "/@£$"
}

resource "vcd_org_user" "sys_admin" {
  count       = var.create_sys_admin ? 1 : 0
  org         = "System"
  name        = var.sys_admin
  description = "Default Sys Admin"
  role        = "System Administrator"
  password    = random_password.sys_admin_pass.result
}

#### Edit Org Admin Role

# data "vcd_rights_bundle" "default_rights_bundle" {
#   name = "Default Rights Bundle"
# }

# resource "vcd_rights_bundle" "default_rights_bundle" {
#   name        = "Default Rights Bundl"
#   description = "Default set of tenant rights"
#   rights = setunion(
#     data.vcd_rights_bundle.default_rights_bundle.rights,      
#     ["vApp: Allow All Extra Config"],                   
#   )
#   publish_to_all_tenants = true
# }

# data "vcd_global_role" "org_admin" {
#   name = "Organization Administrator"
# }

# resource "vcd_global_role" "org_admin" {
#   name        = "Organization Administrator"
#   description = "Built-in rights for administering an organization"
#   rights = setunion(
#     data.vcd_global_role.org_admin.rights,      
#     ["vApp: Allow All Extra Config"],                   
#   )
#   publish_to_all_tenants = true
# }

#### Create IP Spaces
module "vcd_ip_spaces" {
  source        = "../../modules/vcd-modules/vcd-ip-spaces"
  for_each                   = { for ip_space in var.vcd_ip_spaces : ip_space.ip_space_name => ip_space }
  vcd_provider_gateway_name   = each.value.vcd_provider_gateway_name
  ip_space_name               = each.value.ip_space_name
  ip_space_type               = each.value.ip_space_type
  internal_scope              = each.value.internal_scope
  external_scope              = each.value.external_scope
  route_advertisement_enabled = each.value.route_advertisement_enabled
  default_firewall_rule_creation_enabled = each.value.default_firewall_rule_creation_enabled
  default_no_snat_rule_creation_enabled = each.value.default_no_snat_rule_creation_enabled
  default_snat_rule_creation_enabled = each.value.default_snat_rule_creation_enabled
  ip_prefixes                 = each.value.ip_prefixes
  ip_ranges                   = each.value.ip_ranges
}

#### Create VCD Org
module "vcd_org" {
  source        = "../../modules/vcd-modules/vcd-org"
  org_name      = var.org_name
  org_admin     = var.org_admin

  publish_external_catalogs   = var.publish_external_catalogs
  subscribe_external_catalogs = var.subscribe_external_catalogs
}

#### Create VCD pVDCs
module "vcd_provider_vdc" {
  for_each                   = { for pvdc in var.vcd_provider_vdc_variables : pvdc.pvdc_name => pvdc if pvdc.enabled }
  source                     = "../../modules/vcd-modules/vcd-provider-vdc"
  pvdc_name                  = each.key
  vcenter_name               = each.value.vcenter_name
  vcenter_resource_pool_name = each.value.vcenter_resource_pool_name
  nsxt_manager_name          = each.value.nsxt_manager_name
  network_pool_name          = each.value.network_pool_name
  transport_zone_name        = each.value.transport_zone_name
  storage_profile_names      = each.value.storage_profile_names
}

#### Create NSX-T Segment Profile Template
module "nsxt_segment_profile_template" {
  source                        = "../../modules/vcd-modules/nsxt-segment-profile-template"
  segment_profile_template_name = var.segment_profile_template_name
  nsxt_manager_name             = var.source_nsxt_manager_name
  ip_discovery_profile          = var.ip_discovery_profile
  mac_discovery_profile         = var.mac_discovery_profile
  spoof_guard_profile           = var.spoof_guard_profile
  qos_profile                   = var.qos_profile
  security_profile              = var.security_profile
}

#### Create Org VDC
module "vcd_org_vdc" {
  for_each                   = { for vdc in var.vcd_org_vdc_variables : vdc.vdc_name => vdc if vdc.enabled }
  source                     = "../../modules/vcd-modules/vcd-org-vdc"
  vdc_name                   = each.key
  org_name                   = each.value.org_name
  provider_vdc_name          = each.value.provider_vdc_name
  edge_cluster_name          = each.value.edge_cluster_name
  network_pool_name          = each.value.network_pool_name
  vdc_networks_default_segment_profile_template_id  = each.value.vdc_networks_default_segment_profile_template_id
  vapp_networks_default_segment_profile_template_id = module.nsxt_segment_profile_template.vcd_nsxt_segment_profile_template_id
  allocation_model           = each.value.allocation_model
  cpu_allocated_mhz          = each.value.cpu_allocated_mhz
  cpu_limit_mhz              = each.value.cpu_limit_mhz
  cpu_guaranteed             = each.value.cpu_guaranteed
  cpu_speed                  = each.value.cpu_speed
  memory_allocated_mb        = each.value.memory_allocated_mb
  memory_limit_mb            = each.value.memory_limit_mb
  storage_profile_name       = each.value.storage_profile_name
  storage_profile_limit_mb   = each.value.storage_profile_limit_mb
  enable_thin_provisioning   = each.value.enable_thin_provisioning
  enable_fast_provisioning   = each.value.enable_fast_provisioning
  network_quota              = each.value.network_quota
  create_vdc_catalog         = each.value.create_vdc_catalog
  vdc_catalog_name           = each.value.vdc_catalog_name
}

# #### Create Org VDC Routed Network
module "vcd_org_vdc_network" {
  for_each                      = { for vdc_net in var.vcd_org_vdc_network_variables : vdc_net.vdc_network_name => vdc_net }
  source                        = "../../modules/vcd-modules/vcd-org-vdc-network"
  vdc_network_name              = each.value.vdc_network_name
  edge_gw_name                  = each.value.edge_gw_name
  vdc_name                      = each.value.vdc_name
  org_name                      = each.value.org_name
  provider_gateway_name         = each.value.provider_gateway_name
  ip_space_name                 = each.value.ip_space_name
  ip_space_allocation_type      = each.value.ip_space_allocation_type
  ip_space_prefix_lenght        = each.value.ip_space_prefix_lenght
  segment_profile_template_name = each.value.segment_profile_template_name
  allow_guest_vlan              = each.value.allow_guest_vlan
  dhcp_enabled                  = each.value.dhcp_enabled
}
