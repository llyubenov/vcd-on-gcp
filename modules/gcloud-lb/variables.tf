variable "vcd_ui_ip" {
  description = "VCD UI Load Balancer IP Address. If this field is empty, an ephemeral IPv4 address will be assigned."
}

variable "vcd_console_ip" {
  description = "VCD Console Load Balancer IP Address. If this field is empty, an ephemeral IPv4 address will be assigned."
}

variable "vcd_ui_mig" {
  type        = string
  description = "VCD UI Managed Instance Group ID"
}

variable "vcd_console_mig" {
  type        = string
  description = "VCD Console Managed Instance Group ID"
}

variable "lb_cert_filename" {
  type        = string
  description = "The path to the VCD UI Loadbalancer certificate file. The file must be located in 'files/vcd-lb-cert/' folder, e.g. - files/vcd-lb-cert/cert.crt."
}

variable "lb_cert_key_filename" {
  type        = string
  description = "The path to the VCD UI Loadbalancer certificate key file. The file must be located in 'files/vcd-lb-cert/' folder, e.g. - files/vcd-lb-cert/cert.key."
}