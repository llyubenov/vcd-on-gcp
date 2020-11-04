variable "region" {
  description = "GCloud region to use for this deployment."
}

variable "network" {
  description = "The network in which to connect the Filestore."
}

variable "transfer_mount_name" {
  description = "Filestore Mount name that will be used for VCd Transfer Store"
  default     = "xfer"
}