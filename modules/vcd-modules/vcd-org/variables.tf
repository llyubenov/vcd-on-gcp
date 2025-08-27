variable "org_name" {
  description = "Name of the VCD Organization to be created."
  type        = string
  default     = ""
}

variable "org_description" {
  description = "Description of the VCD Organization thas is being created."
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
