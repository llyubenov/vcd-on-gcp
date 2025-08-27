variable "pvdc_name" {
  description = "Name of the Provider VDC."
  type        = string
  default     = ""
}

variable "vcenter_name" {
  description = "Name of the vCenter in VCD to use for the createion of the pVDC."
  type        = string
  default     = ""
}

variable "vcenter_resource_pool_name" {
  description = "Name of the Resource pool in vCenter backing this pVDC."
  type        = string
  default     = ""
}

variable "nsxt_manager_name" {
  description = "Name of the NSX-T Manager in VCD to use for the createion of the pVDC."
  type        = string
  default     = ""
}

variable "network_pool_name" {
  description = "Name of the NSX-T Network Pool to be created for this pVDC."
  type        = string
  default     = ""
}

variable "network_pool_description" {
  description = "Description of the NSX-T Network Pool for this pVDC."
  type        = string
  default     = ""
}

variable "transport_zone_name" {
  description = "Name of the NSX-T transport zone to be used for the Network Pool."
  type        = string
  default     = ""
}

variable "storage_profile_names" {
  description = "Name of the NSX-T Network Pool to be used by this pVDC."
  type        = list(string)
  default     = []
}
