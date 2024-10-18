variable "region" {
  description = "GCloud region to use for this deployment."
}

variable "vcd_binary_filename" {
  type        = string
  description = "The VCD binary to be uploaded to the GCloud Storage Bucket. The binary file must be located in 'files/vcd-binaries/' folder."
}

variable "vcd_cert_file" {
  type        = string
  default     = ""
  description = "vCD Certificate file. The file must be located in 'files/vcd-cert-file/' folder, e.g. - vcd_cert.pem."
}

variable "vcd_cert_private_key_file" {
  type        = string
  default     = ""
  description = "vCD Certificate Private Key file. The file must be located in 'files/vcd-cert-file/' folder, e.g. - vcd_cert.key."
}
