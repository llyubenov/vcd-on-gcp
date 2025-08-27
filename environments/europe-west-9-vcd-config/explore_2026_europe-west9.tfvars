sys_admin_user = "vcd_admin"
sys_admin_password_b64 = "VMware123!"
vcd_url = "https://europe-west9-vcd01.dev.hol.broadcom.com/api"
create_sys_admin = true
sys_admin = "vlp-sysadmin"
vcd_allow_unverified_ssl = true

#### NSX-T Segment Profile ####
segment_profile_template_name = "europe-west9-vcd01-segment-profile"
source_nsxt_manager_name = "europe-west9-sddc1-nsxt"
ip_discovery_profile = "vcloud-ip-discovery-profile"
mac_discovery_profile = "vcloud-mac-learning"
security_profile = "vcloud-segment-security"
# spoof_guard_profile = "NSX-T Default Segment Profile"
# qos_profile = "NSX-T Default Segment Profile"

####### IP Spaces Variables
vcd_ip_spaces = [
  {
    vcd_provider_gateway_name = "europe-west9-sddc1-t0"
    ip_space_name = "europe-west9-sddc1-ip-space-1"
    ip_space_type = "PUBLIC"
    internal_scope = ["192.168.20.0/22"]
    external_scope = ""
    route_advertisement_enabled = false
    default_firewall_rule_creation_enabled = false
    default_no_snat_rule_creation_enabled = false
    default_snat_rule_creation_enabled = false
    ip_prefixes =  [
      {
        default_quota = -1
        first_ip = "192.168.20.0"
        prefix_length = 23
        prefix_count = 2
      }
    ]
    ip_ranges =  []
  },
  {
    vcd_provider_gateway_name = "europe-west9-sddc2-t0"
    ip_space_name = "europe-west9-sddc2-ip-space-1"
    ip_space_type = "PUBLIC"
    internal_scope = ["192.168.24.0/22"]
    external_scope = ""
    route_advertisement_enabled = false
    default_firewall_rule_creation_enabled = false
    default_no_snat_rule_creation_enabled = false
    default_snat_rule_creation_enabled = false
    ip_prefixes =  [
      {
        default_quota = -1
        first_ip = "192.168.24.0"
        prefix_length = 23
        prefix_count = 2
      }
    ]
    ip_ranges =  []
  },
  {
    vcd_provider_gateway_name = "europe-west9-sddc3-t0"
    ip_space_name = "europe-west9-sddc3-ip-space-1"
    ip_space_type = "PUBLIC"
    internal_scope = ["192.168.28.0/22"]
    external_scope = ""
    route_advertisement_enabled = false
    default_firewall_rule_creation_enabled = false
    default_no_snat_rule_creation_enabled = false
    default_snat_rule_creation_enabled = false
    ip_prefixes =  [
      {
        default_quota = -1
        first_ip = "192.168.28.0"
        prefix_length = 23
        prefix_count = 2
      }
    ]
    ip_ranges =  []
  },
  {
    vcd_provider_gateway_name = "europe-west9-sddc4-t0"
    ip_space_name = "europe-west9-sddc4-ip-space-1"
    ip_space_type = "PUBLIC"
    internal_scope = ["192.168.32.0/22"]
    external_scope = ""
    route_advertisement_enabled = false
    default_firewall_rule_creation_enabled = false
    default_no_snat_rule_creation_enabled = false
    default_snat_rule_creation_enabled = false
    ip_prefixes =  [
      {
        default_quota = -1
        first_ip = "192.168.32.0"
        prefix_length = 23
        prefix_count = 2
      }
    ]
    ip_ranges =  []
  }
]

#### VCD Org ####
org_name = "europe-west9-vcd01-explore"
org_admin = "vlp"
publish_external_catalogs = true
subscribe_external_catalogs = true

#### VCD Provider VDCs ####
vcd_provider_vdc_variables = [
  {
    enabled = true
    pvdc_name = "europe-west9-vcd01-pvdc1"
    vcenter_name = "europe-west9-sddc1-vcenter"
    vcenter_resource_pool_name = "Workload"
    nsxt_manager_name = "europe-west9-sddc1-nsxt"
    network_pool_name = "europe-west9-vcd01-pvdc1-netpool"
    transport_zone_name = "TZ-OVERLAY"
    storage_profile_names =  ["vSAN Default Storage Policy","vSAN ESA Default Policy - RAID5","vSAN ESA Default Policy - RAID6"]
  },
  {
    enabled = true
    pvdc_name = "europe-west9-vcd01-pvdc2"
    vcenter_name = "europe-west9-sddc2-vcenter"
    vcenter_resource_pool_name = "Workload"
    nsxt_manager_name = "europe-west9-sddc2-nsxt"
    network_pool_name = "europe-west9-vcd01-pvdc2-netpool"
    transport_zone_name = "TZ-OVERLAY"
    storage_profile_names =  ["vSAN Default Storage Policy","vSAN ESA Default Policy - RAID5","vSAN ESA Default Policy - RAID6"]
  },
  {
    enabled = true
    pvdc_name = "europe-west9-vcd01-pvdc3"
    vcenter_name = "europe-west9-sddc3-vcenter"
    vcenter_resource_pool_name = "Workload"
    nsxt_manager_name = "europe-west9-sddc3-nsxt"
    network_pool_name = "europe-west9-vcd01-pvdc3-netpool"
    transport_zone_name = "TZ-OVERLAY"
    storage_profile_names =  ["vSAN Default Storage Policy","vSAN ESA Default Policy - RAID5","vSAN ESA Default Policy - RAID6"]
  },
  {
    enabled = true
    pvdc_name = "europe-west9-vcd01-pvdc4"
    vcenter_name = "europe-west9-sddc4-vcenter"
    vcenter_resource_pool_name = "Workload"
    nsxt_manager_name = "europe-west9-sddc4-nsxt"
    network_pool_name = "europe-west9-vcd01-pvdc4-netpool"
    transport_zone_name = "TZ-OVERLAY"
    storage_profile_names =  ["vSAN Default Storage Policy","vSAN ESA Default Policy - RAID5","vSAN ESA Default Policy - RAID6"]
  },
]

#### VCD Org VDCs
vcd_org_vdc_variables = [
  {
    enabled = true
    vdc_name = "europe-west9-vcd01-vdc1"
    org_name = "europe-west9-vcd01-explore"
    provider_vdc_name = "europe-west9-vcd01-pvdc1"
    edge_cluster_name = "edge-cluster"
    network_pool_name = "europe-west9-vcd01-pvdc1-netpool"
    vdc_networks_default_segment_profile_template_id = null
    vapp_networks_default_segment_profile_template_id = null
    allocation_model = "Flex"
    cpu_allocated_mhz = 5604000
    cpu_limit_mhz = 5604000
    cpu_guaranteed = 0
    cpu_speed = 2600
    memory_allocated_mb = 23592960
    memory_limit_mb = 23592960
    storage_profile_name = "vSAN ESA Default Policy - RAID5"
    storage_profile_limit_mb = 734003200
    enable_thin_provisioning = true
    enable_fast_provisioning = true
    network_quota = 1000
  },
  {
    enabled = true
    vdc_name = "europe-west9-vcd01-vdc2"
    org_name = "europe-west9-vcd01-explore"
    provider_vdc_name = "europe-west9-vcd01-pvdc2"
    edge_cluster_name = "edge-cluster"
    network_pool_name = "europe-west9-vcd01-pvdc2-netpool"
    vdc_networks_default_segment_profile_template_id = null
    vapp_networks_default_segment_profile_template_id = null
    allocation_model = "Flex"
    cpu_allocated_mhz = 5604000
    cpu_limit_mhz = 5604000
    cpu_guaranteed = 0
    cpu_speed = 2600
    memory_allocated_mb = 23592960
    memory_limit_mb = 23592960
    storage_profile_name = "vSAN ESA Default Policy - RAID5"
    storage_profile_limit_mb = 734003200
    enable_thin_provisioning = true
    enable_fast_provisioning = true
    network_quota = 1000
  },
  {
    enabled = true
    vdc_name = "europe-west9-vcd01-vdc3"
    org_name = "europe-west9-vcd01-explore"
    provider_vdc_name = "europe-west9-vcd01-pvdc3"
    edge_cluster_name = "edge-cluster"
    network_pool_name = "europe-west9-vcd01-pvdc3-netpool"
    vdc_networks_default_segment_profile_template_id = null
    vapp_networks_default_segment_profile_template_id = null
    allocation_model = "Flex"
    cpu_allocated_mhz = 5604000
    cpu_limit_mhz = 5604000
    cpu_guaranteed = 0
    cpu_speed = 2600
    memory_allocated_mb = 23592960
    memory_limit_mb = 23592960
    storage_profile_name = "vSAN ESA Default Policy - RAID5"
    storage_profile_limit_mb = 734003200
    enable_thin_provisioning = true
    enable_fast_provisioning = true
    network_quota = 1000
  },
  {
    enabled = true
    vdc_name = "europe-west9-vcd01-vdc4"
    org_name = "europe-west9-vcd01-explore"
    provider_vdc_name = "europe-west9-vcd01-pvdc4"
    edge_cluster_name = "edge-cluster"
    network_pool_name = "europe-west9-vcd01-pvdc4-netpool"
    vdc_networks_default_segment_profile_template_id = null
    vapp_networks_default_segment_profile_template_id = null
    allocation_model = "Flex"
    cpu_allocated_mhz = 7005000
    cpu_limit_mhz = 7005000
    cpu_guaranteed = 0
    cpu_speed = 2600
    memory_allocated_mb = 29569843
    memory_limit_mb = 29569843
    storage_profile_name = "vSAN ESA Default Policy - RAID5"
    storage_profile_limit_mb = 916455424
    enable_thin_provisioning = true
    enable_fast_provisioning = true
    network_quota = 1000
  }
]

#### VCD Org VDC Networks
vcd_org_vdc_network_variables = [
  {
    vdc_network_name = "europe-west9-vcd01-vdc1-net1"
    edge_gw_name = "europe-west9-vcd01-vdc1-net1-gw"
    vdc_name = "europe-west9-vcd01-vdc1"
    org_name = "europe-west9-vcd01-explore"
    provider_gateway_name = "europe-west9-sddc1-t0"
    ip_space_name = "europe-west9-sddc1-ip-space-1"
    ip_space_allocation_type = "IP_PREFIX"
    ip_space_prefix_lenght = 23
    segment_profile_template_name = "europe-west9-vcd01-segment-profile"
    allow_guest_vlan = false
    dhcp_enabled = false
  },
  {
    vdc_network_name = "europe-west9-vcd01-vdc2-net1"
    edge_gw_name = "europe-west9-vcd01-vdc2-net1-gw"
    vdc_name = "europe-west9-vcd01-vdc2"
    org_name = "europe-west9-vcd01-explore"
    provider_gateway_name = "europe-west9-sddc2-t0"
    ip_space_name = "europe-west9-sddc2-ip-space-1"
    ip_space_allocation_type = "IP_PREFIX"
    ip_space_prefix_lenght = 23
    segment_profile_template_name = "europe-west9-vcd01-segment-profile"
    allow_guest_vlan = false
    dhcp_enabled = false
  },
  {
    vdc_network_name = "europe-west9-vcd01-vdc3-net1"
    edge_gw_name = "europe-west9-vcd01-vdc3-net1-gw"
    vdc_name = "europe-west9-vcd01-vdc3"
    org_name = "europe-west9-vcd01-explore"
    provider_gateway_name = "europe-west9-sddc3-t0"
    ip_space_name = "europe-west9-sddc3-ip-space-1"
    ip_space_allocation_type = "IP_PREFIX"
    ip_space_prefix_lenght = 23
    segment_profile_template_name = "europe-west9-vcd01-segment-profile"
    allow_guest_vlan = false
    dhcp_enabled = false
  },
  {
    vdc_network_name = "europe-west9-vcd01-vdc4-net1"
    edge_gw_name = "europe-west9-vcd01-vdc4-net1-gw"
    vdc_name = "europe-west9-vcd01-vdc4"
    org_name = "europe-west9-vcd01-explore"
    provider_gateway_name = "europe-west9-sddc4-t0"
    ip_space_name = "europe-west9-sddc4-ip-space-1"
    ip_space_allocation_type = "IP_PREFIX"
    ip_space_prefix_lenght = 23
    segment_profile_template_name = "europe-west9-vcd01-segment-profile"
    allow_guest_vlan = false
    dhcp_enabled = false
  }
]
