variable "provider_vdc_name" {
  description = "Name of the Provider VDC."
  type        = string
  default     = ""
}

variable "org_name" {
  description = "Name of the VCD Org in which the PVDC will be created."
  type        = string
  default     = ""
}

variable "vdc_name" {
  description = "Name of the Org VDC."
  type        = string
  default     = ""
}

variable "edge_cluster_name" {
  description = "Name of the NSX-T Edge Cluster to be configured for this VDC."
  type        = string
  default     = ""
}

variable "allocation_model" {
  description = "The allocation model used by this VDC; must be one of - AllocationVApp ('Pay as you go'), AllocationPool, ReservationPool or Flex."
  type        = string
  default     = ""
}

variable "elasticity" {
  description = "Indicates if the Flex VDC should be elastic. Required with the Flex allocation model."
   type       = bool
  default     = false
}

variable "include_vm_memory_overhead" {
  description = "Indicates if the Flex VDC should include memory overhead into its accounting for admission control. Required with the Flex allocation model."
   type       = bool
  default     = false
}

variable "network_pool_name" {
  description = "Name of the NSX-T Network Pool to be created for this pVDC."
  type        = string
  default     = ""
}

variable "cpu_allocated_mhz" {
  description = "CPU capacity that is committed to be available. Value in MHz."
  type        = number
}

variable "cpu_limit_mhz" {
  description = "Capacity limit relative to the value specified for Allocation. It must not be less than that value. If it is greater than that value, it implies over provisioning. A value of 0 specifies unlimited units. Value in MHz."
  type        = number
}

variable "memory_allocated_mb" {
  description = "Memory capacity that is committed to be available. Value in MB."
  type        = number
}

variable "memory_limit_mb" {
  description = "Memory capacity limit relative to the value specified for Allocation. It must not be less than that value. If it is greater than that value, it implies over provisioning. A value of 0 specifies unlimited units. Value in MB."
  type        = number
}

variable "storage_profile_name" {
  description = "Name of Provider VDC storage profile."
  type        = string
  default     = ""
}

variable "storage_profile_limit_mb" {
  description = "Maximum number of MB allocated for this storage profile. A value of 0 specifies unlimited MB."
  type        = number
}

variable "network_quota" {
  description = "Maximum number of network objects that can be deployed in this VDC. Defaults to 0, which means no networks can be deployed."
  type        = number
}

variable "cpu_guaranteed" {
  description = "Percentage of allocated CPU resources guaranteed to vApps deployed in this VDC. For example, if this value is 0.75, then 75% of allocated resources are guaranteed. Required when allocation_model is AllocationVApp, AllocationPool or Flex."
  type        = number
  default     = 0
}

variable "cpu_speed" {
  description = "Specifies the clock frequency, in Megahertz, for any virtual CPU that is allocated to a VM. A VM with 2 vCPUs will consume twice as much of this value. Ignored for ReservationPool. Required when allocation_model is AllocationVApp, AllocationPool or Flex, and may not be less than 256 MHz."
  type        = number
  default     = 1000
}

variable "memory_guaranteed" {
  description = "Percentage of allocated memory resources guaranteed to vApps deployed in this VDC. For example, if this value is 0.75, then 75% of allocated resources are guaranteed. Required when allocation_model is AllocationVApp, AllocationPool or Flex. When Allocation model is AllocationPool minimum value is 0.2."
  type        = number
  default     = 0
}

variable "enable_thin_provisioning" {
  description = "Enable Thin Provisioning."
  type        = bool
  default     = false
}

variable "enable_fast_provisioning" {
  description = "Enable Fast Provisioning."
  type        = bool
  default     = false
}

variable "vdc_networks_default_segment_profile_template_id" {
  description = "Default Segment Profile Template ID for all VDC Networks in a VDC."
  type        = string
  default     = ""
}

variable "vapp_networks_default_segment_profile_template_id" {
  description = "Default Segment Profile Template ID for all vApp Networks in a VDC."
  type        = string
  default     = ""
}

variable "create_vdc_catalog" {
  description = "Create a Catalog in the VDC that's being created."
  type        = bool
  default     = false
}

variable "vdc_catalog_name" {
  description = "Name of catalog to be created in this VDC."
  type        = string
  default     = ""
}
