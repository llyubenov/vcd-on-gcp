sys_admin_user = "vcd_admin"
sys_admin_password_b64 = "VMware123!"
vcd_url = "https://34.49.175.227/api"
create_sys_admin = true
sys_admin = "vlp-sysadmin"
vcd_allow_unverified_ssl = true


#### Explore Org ####
org_name = "gcp-vcd01-explore"
org_admin = "vlp"
publish_external_catalogs = true
subscribe_external_catalogs = true

#### NSX-T Segment Profile ####
segment_profile_template_name = "explore-segment-profile-template"
source_nsxt_manager_name = "nsx-366321.bc0beef7.europe-west3.gve.goog"
ip_discovery_profile = "vcloud-ip-discovery"
mac_discovery_profile = "vcloud-mac-learn"
security_profile = "vcloud-segment-security"

#### VCD Provider VDCs ####
vcd_provider_vdc_variables = [
  {
    enabled = true
    pvdc_name = "gcp-vcd01-explore-pvdc1"
    vcenter_name = "vcsa-361581.bc0beef7.europe-west3.gve.goog"
    vcenter_resource_pool_name = "Workload"
    nsxt_manager_name = "nsx-366321.bc0beef7.europe-west3.gve.goog"
    network_pool_name = "gcp-vcd01-explore-pvdc1-netpool"
    transport_zone_name = "TZ-OVERLAY"
    storage_profile_names =  ["vSAN Default Storage Policy","raid5-compute"]
  },
  {
    enabled = true
    pvdc_name = "gcp-vcd01-explore-pvdc2"
    vcenter_name = "vcsa-362767.adfb3252.europe-west3.gve.goog"
    vcenter_resource_pool_name = "Workload"
    nsxt_manager_name = "nsx-366317.adfb3252.europe-west3.gve.goog"
    network_pool_name = "gcp-vcd01-explore-pvdc2-netpool"
    transport_zone_name = "TZ-OVERLAY"
    storage_profile_names =  ["vSAN Default Storage Policy","raid5-compute"]
  },
  {
    enabled = true
    pvdc_name = "gcp-vcd01-explore-pvdc3"
    vcenter_name = "vcsa-362755.b553e76f.europe-west3.gve.goog"
    vcenter_resource_pool_name = "Workload"
    nsxt_manager_name = "nsx-366319.b553e76f.europe-west3.gve.goog"
    network_pool_name = "gcp-vcd01-explore-pvdc3-netpool"
    transport_zone_name = "TZ-OVERLAY"
    storage_profile_names =  ["vSAN Default Storage Policy","raid5-compute"]
  },
  {
    enabled = true
    pvdc_name = "gcp-vcd01-explore-pvdc4"
    vcenter_name = "vcsa-363653.b9ff5d5c.europe-west3.gve.goog"
    vcenter_resource_pool_name = "Workload"
    nsxt_manager_name = "nsx-366310.b9ff5d5c.europe-west3.gve.goog"
    network_pool_name = "gcp-vcd01-explore-pvdc4-netpool"
    transport_zone_name = "TZ-OVERLAY"
    storage_profile_names =  ["vSAN Default Storage Policy","raid5-compute"]
  },
]

#### VCD Org VDCs
vcd_org_vdc_variables = [
  {
    enabled = true
    vdc_name = "gcp-vcd01-explore-vdc1"
    org_name = "gcp-vcd01-explore"
    provider_vdc_name = "gcp-vcd01-explore-pvdc1"
    edge_cluster_name = "edge-cluster"
    network_pool_name = "gcp-vcd01-explore-pvdc1-netpool"
    vdc_networks_default_segment_profile_template_id = null
    vapp_networks_default_segment_profile_template_id = null
    allocation_model = "Flex"
    cpu_allocated_mhz = 1660000
    cpu_limit_mhz = 1660000
    cpu_guaranteed = 0
    cpu_speed = 2200
    memory_allocated_mb = 29286
    memory_limit_mb = 29286
    storage_profile_name = "raid5-compute"
    storage_profile_limit_mb = 98404000
    enable_thin_provisioning = true
    enable_fast_provisioning = true
    network_quota = 1000
  },
  {
    enabled = true
    vdc_name = "gcp-vcd01-explore-vdc2"
    org_name = "gcp-vcd01-explore"
    provider_vdc_name = "gcp-vcd01-explore-pvdc2"
    edge_cluster_name = "edge-cluster"
    network_pool_name = "gcp-vcd01-explore-pvdc2-netpool"
    vdc_networks_default_segment_profile_template_id = null
    vapp_networks_default_segment_profile_template_id = null
    allocation_model = "Flex"
    cpu_allocated_mhz = 1660000
    cpu_limit_mhz = 1660000
    cpu_guaranteed = 0
    cpu_speed = 2200
    memory_allocated_mb = 29286
    memory_limit_mb = 29286
    storage_profile_name = "raid5-compute"
    storage_profile_limit_mb = 98404000
    enable_thin_provisioning = true
    enable_fast_provisioning = true
    network_quota = 1000
  },{
    enabled = true
    vdc_name = "gcp-vcd01-explore-vdc3"
    org_name = "gcp-vcd01-explore"
    provider_vdc_name = "gcp-vcd01-explore-pvdc3"
    edge_cluster_name = "edge-cluster"
    network_pool_name = "gcp-vcd01-explore-pvdc3-netpool"
    vdc_networks_default_segment_profile_template_id = null
    vapp_networks_default_segment_profile_template_id = null
    allocation_model = "Flex"
    cpu_allocated_mhz = 1660000
    cpu_limit_mhz = 1660000
    cpu_guaranteed = 0
    cpu_speed = 2200
    memory_allocated_mb = 29286
    memory_limit_mb = 29286
    storage_profile_name = "raid5-compute"
    storage_profile_limit_mb = 98404000
    enable_thin_provisioning = true
    enable_fast_provisioning = true
    network_quota = 1000
  },{
    enabled = true
    vdc_name = "gcp-vcd01-explore-vdc4"
    org_name = "gcp-vcd01-explore"
    provider_vdc_name = "gcp-vcd01-explore-pvdc4"
    edge_cluster_name = "edge-cluster"
    network_pool_name = "gcp-vcd01-explore-pvdc4-netpool"
    vdc_networks_default_segment_profile_template_id = null
    vapp_networks_default_segment_profile_template_id = null
    allocation_model = "Flex"
    cpu_allocated_mhz = 1660000
    cpu_limit_mhz = 1660000
    cpu_guaranteed = 0
    cpu_speed = 2200
    memory_allocated_mb = 29286
    memory_limit_mb = 29286
    storage_profile_name = "raid5-compute"
    storage_profile_limit_mb = 98404000
    enable_thin_provisioning = true
    enable_fast_provisioning = true
    network_quota = 1000
  }
]
