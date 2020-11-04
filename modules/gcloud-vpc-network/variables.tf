variable "region" {
  description = "GCloud region to use for this deployment."
}

variable "subnet_cidr" {
  type        = string
  description = "The CIDR block for the VCD Subnetwork."
}