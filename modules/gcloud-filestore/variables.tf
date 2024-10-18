variable "region" {
  description = "GCloud region to use for this deployment."
}

variable "network" {
  description = "The network in which to connect the Filestore."
}

variable "transfer_store_size_gb" {
  description = "Filestore Mount capacity in GiB. This must be at least 1024 GiB for the standard tier, or 2560 GiB for the premium tier."
  default     = ""
}

variable "transfer_mount_name" {
  description = "Filestore Mount name that will be used for VCd Transfer Store"
  default     = "xfer"
}
