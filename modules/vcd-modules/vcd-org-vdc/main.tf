data "vcd_provider_vdc" "provider_vdc" {
  name = var.provider_vdc_name
}

data "vcd_nsxt_edge_cluster" "edge_cluster" {
  provider_vdc_id = data.vcd_provider_vdc.provider_vdc.id
  name            = var.edge_cluster_name
}

#### Created Org VDC
resource "vcd_org_vdc" "org_vdc" {
  name = var.vdc_name
  org  = var.org_name

  allocation_model  = var.allocation_model
  network_pool_name = var.network_pool_name
  provider_vdc_name = var.provider_vdc_name

  compute_capacity {
    cpu {
      allocated = var.cpu_allocated_mhz
      limit     = var.cpu_limit_mhz
    }

    memory {
      allocated = var.memory_allocated_mb
      limit     = var.memory_limit_mb
    }
  }

  storage_profile {
    name    = var.storage_profile_name
    enabled = true
    limit   = var.storage_profile_limit_mb
    default = true
  }

  network_quota              = var.network_quota
  memory_guaranteed          = var.memory_guaranteed
  cpu_guaranteed             = var.cpu_guaranteed
  cpu_speed                  = var.cpu_speed
  enable_thin_provisioning   = var.enable_thin_provisioning
  enable_fast_provisioning   = var.enable_fast_provisioning
  elasticity                 = var.elasticity
  include_vm_memory_overhead = var.include_vm_memory_overhead

  
  delete_force             = true
  delete_recursive         = true
}

#### Create Network profile for this VDC
resource "vcd_org_vdc_nsxt_network_profile" "vdc_network_profile" {
  org = var.org_name
  vdc = vcd_org_vdc.org_vdc.name

  edge_cluster_id                                   = data.vcd_nsxt_edge_cluster.edge_cluster.id
  vdc_networks_default_segment_profile_template_id  = var.vdc_networks_default_segment_profile_template_id != "" ? var.vdc_networks_default_segment_profile_template_id : null
  vapp_networks_default_segment_profile_template_id = var.vapp_networks_default_segment_profile_template_id != "" ? var.vapp_networks_default_segment_profile_template_id : null
}


#### Default Catalog for this Org VDC
data "vcd_storage_profile" "storage_profile" {
  count = var.create_vdc_catalog ? 1 : 0
  org  = var.org_name
  vdc  = vcd_org_vdc.org_vdc.name
  name = var.storage_profile_name
}

resource "vcd_catalog" "vdc_Catalog" {
  count = var.create_vdc_catalog ? 1 : 0
  org = var.org_name

  name               = var.vdc_catalog_name != "" ? var.vdc_catalog_name : "${vcd_org_vdc.org_vdc.name}-catalog"
  description        = "Default VDC catalog"
  storage_profile_id = data.vcd_storage_profile.storage_profile[0].id

  delete_recursive = true
  delete_force     = true
}
