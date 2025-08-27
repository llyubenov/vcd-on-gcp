
variable "vcd_provider_gateway_name" {
  description = "Provider Gateway Name."
  type        = string
}

variable "ip_space_name" {
  description = "Name of the IP Space."
  type        = string
}

variable "ip_space_type" {
  description = "IP Space type, one of 'PUBLIC', 'SHARED_SERVICES', 'PRIVATE'"
  type        = string
}

variable internal_scope {
  description = "The internal scope of an IP space is a list of CIDR notations that defines the exact span of IP addresses in which all ranges and blocks must be contained in."
  type        = list(string)
  default     = []
}

variable "external_scope" {
  description = "The external scope defines the total span of IP addresses to which the IP space has access, for example the internet or a WAN."
  type        = string
}

variable "route_advertisement_enabled" {
  description = "Toggle on the route advertisement option to enable advertising networks with IP prefixes from this IP space."
  type = bool
  default = false
}

variable "default_firewall_rule_creation_enabled" {
  description = "Defines whether default firewall rule creation should be enabled."
  type = bool
  default = false
}

variable "default_no_snat_rule_creation_enabled" {
  description = "Defines whether NO SNAT rule creation should be enabled."
  type = bool
  default = false
}

variable "default_snat_rule_creation_enabled" {
  description = "Defines whether SNAT rule creation should be enabled."
  type = bool
  default = false
}

variable "ip_prefixes" {
  type = list(object({
    default_quota = number
    first_ip = string
    prefix_length = number
    prefix_count = number
  }))
  default = []
}

variable "ip_ranges" {
  type = list(object({
    start_address = string
    end_address = string
  }))
  default = []
}
