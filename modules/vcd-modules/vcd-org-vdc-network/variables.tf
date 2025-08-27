
variable "provider_gateway_name" {
  description = "Provider Gateway Name."
  type        = string
}

variable "org_name" {
  description = "Name of the Org in which the Edge GW will be deployed."
  type        = string
}

variable "vdc_name" {
  description = "Name of the Org VDC in which the Edge GW will be deployed."
  type        = string
}

variable "edge_gw_name" {
  description = "Name of the Edge Gateway."
  type        = string
}

variable "vdc_network_name" {
  description = "Name of the Org VDC Network that will be deployed."
  type        = string
}

variable "ip_space_name" {
  description = "Name of the IP Space to use for this VDC Netowrk."
  type        = string
}

variable "ip_space_allocation_type" {
  description = "The IP Space alocation type - One of FLOATING_IP, IP_PREFIX"
  type        = string
}

variable "ip_space_prefix_lenght" {
  description = "The IP Space alocation lengh. Required when ip_space_allocation_type = IP_PREFIX !!!"
  type        = number
}

variable "allow_guest_vlan" {
  description = "Set to 'true' if network should allow guest VLAN tagging."
  type        = bool
}

variable "segment_profile_template_name" {
  description = "NSX-T Segment Profile Name."
  type        = string
  default     = ""
}

variable "dhcp_enabled" {
  description = "Enable DHCP for the VDC network."
  type        = bool
}
