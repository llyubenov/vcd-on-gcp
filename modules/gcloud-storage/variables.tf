variable "region" {
  description = "GCloud region to use for this deployment."
}

variable "vcd_binary_filename" {
  type        = string
  description = "The VCD binary to be uploaded to the GCloud Storage Bucket. The binary file must be located in 'files/vcd-binaries/' folder."
}

variable "vcd_keystore_filename" {
  type        = string
  description = "The VCD Java Keystore file to be uploaded to the GCloud Storage Bucket. The java keystoire file must be located in 'files/vcd-cert-file/' folder."
}