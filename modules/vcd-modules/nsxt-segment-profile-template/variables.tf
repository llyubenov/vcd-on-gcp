variable "segment_profile_template_name" {
  description = "NSX-T Segment Profile Name."
  type        = string
  default     = ""
}
variable "segment_profile_template_description" {
  description = ""
  type        = string
  default     = ""
}
variable "nsxt_manager_name" {
  description = "Source NSX-T Manager Name in VCD."
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
