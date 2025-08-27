variable "vcd_url" {
  description = "API Token with Sys Admin permissions."
  type        = string
  default     = ""
}

variable "sys_admin_user" {
  description = "VCD local user Sys Admin permissions."
  type        = string
  default     = ""
}
variable "sys_admin_password_b64" {
  description = "Base64 encoded Sys Admin password."
  type        = string
  default     = ""
}

variable "vcd_allow_unverified_ssl" {
  description = "Disable SSL certificate validation."
  type        = string
  default     = "false"
}

variable "create_sys_admin" {
  description = "Create Sys Admin User."
  type = bool
  default = false
}

variable "sys_admin" {
  description = "Name of the Sys Admin user to be created."
  type        = string
  default     = ""
}

variable "org_name" {
  description = "Name of the VCD Organization to be created."
  type        = string
  default     = ""
}

variable "org_admin" {
  description = "Name of the VCD Organization Admin user to be created."
  type        = string
  default     = ""
}

variable "publish_external_catalogs" {
  description = "Public External Catalogs."
  type = bool
  default = false
}

variable "subscribe_external_catalogs" {
  description = "Subscribe to External Catalogs."
  type = bool
  default = false
}


variable "segment_profile_template_name" {
  description = "NSX-T Segment Profile Name."
  type        = string
  default     = ""
}

variable "source_nsxt_manager_name" {
  description = "Source NSX-T Manager Name in VCD for creating the Segment Profile Template."
  type        = string
  default     = ""
}

variable "ip_discovery_profile" {
  description = "IP Discovery Segment Profile Name in Source NSX-T Manageer."
  type        = string
  default     = ""
}

variable "mac_discovery_profile" {
  description = "MAC Discovery Segment Profile Name in Source NSX-T Manageer."
  type        = string
  default     = ""
}

variable "spoof_guard_profile" {
  description = "Spoof Guard Segment Profile Name in Source NSX-T Manageer."
  type        = string
  default     = ""
}

variable "qos_profile" {
  description = "QoS Segment Profile Name in Source NSX-T Manageer."
  type        = string
  default     = ""
}

variable "security_profile" {
  description = "Security Segment Profile Name in Source NSX-T Manageer."
  type        = string
  default     = ""
}

####### VCD Provider VDC Variables
variable "vcd_provider_vdc_variables" {
  type = list(object({
    enabled = bool
    pvdc_name = string
    vcenter_name = string
    vcenter_resource_pool_name = string
    nsxt_manager_name = string
    network_pool_name = string
    transport_zone_name = string
    storage_profile_names =  list(string)
  }))
  default = [
  {
    enabled = false
    pvdc_name = "pvdc1"
    vcenter_name = "vcenter1"
    vcenter_resource_pool_name = "workload"
    nsxt_manager_name = "nsxt1"
    network_pool_name = "netpool1"
    transport_zone_name = "tz1"
    storage_profile_names =  ["*"]
  },
  ]
}

####### VCD Org VDC Variables
variable "vcd_org_vdc_variables" {
  type = list(object({
    enabled = bool
    vdc_name = string
    org_name = string
    provider_vdc_name = string
    edge_cluster_name = string
    network_pool_name = string
    vdc_networks_default_segment_profile_template_id = string
    vapp_networks_default_segment_profile_template_id = string
    allocation_model = string
    cpu_allocated_mhz = number
    cpu_limit_mhz = number
    cpu_guaranteed = number
    cpu_speed = number
    memory_allocated_mb = number
    memory_limit_mb = number
    storage_profile_name = string
    storage_profile_limit_mb = number
    enable_thin_provisioning = bool
    enable_fast_provisioning = bool
    network_quota = number
  }))
  default = [
  {
    enabled = false
    vdc_name = "vdc1"
    org_name = "org1"
    provider_vdc_name = "pvdc1"
    edge_cluster_name = "edge-cluster"
    network_pool_name = "pool1"
    vdc_networks_default_segment_profile_template_id = null
    vapp_networks_default_segment_profile_template_id = null
    allocation_model = "Flex"
    cpu_allocated_mhz = 1000
    cpu_limit_mhz = 2000
    cpu_guaranteed = 0
    cpu_speed = 2000
    memory_allocated_mb = 1000
    memory_limit_mb = 2000
    storage_profile_name = "*"
    storage_profile_limit_mb = 0
    enable_thin_provisioning = true
    enable_fast_provisioning = true
    network_quota = 1000
  },
  ]
}
