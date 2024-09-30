variable "gcloud_project" {
  type        = string
  description = "GCloud project for this deployment."
  default     = ""
}

variable "gcloud_region" {
  default     = "us-central1"
  description = "GCE region to use for this deployment."
}

variable "gcloud_subnet_cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = "The CIDR block for the VCD Subnetwork."
}

variable "sql_deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance."
  type        = bool
  default     = false
}

variable "target_size_ui" {
  description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
  default     = 1
  type        = number
}

variable "target_size_console" {
  description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
  default     = 1
  type        = number
}

variable "vcd_binary_filename" {
  type        = string
  default     = "vmware-vcloud-director-distribution-10.2.0-17029810.bin"
  description = "The VCD binary to be uploaded to the GCloud Storage Bucket. The binary file must be located in 'files/vcd-binaries/' folder."
}

variable "vcd_keystore_filename" {
  type        = string
  default     = "certificates.ks"
  description = "The VCD Java Keystore file to be uploaded to the GCloud Storage Bucket. The java keystoire file must be located in 'files/vcd-cert-file/' folder, e.g. - certificates.ks."
}

variable "vcd_keystore_password" {
  description = "VCD Java Keystore file password"
  default     = ""
}

variable "lb_cert_filename" {
  type        = string
  default     = ""
  description = "The name of the VCD UI Loadbalancer certificate file. The file must be located in 'files/vcd-lb-cert/' folder, e.g. - cert.crt."
}

variable "lb_cert_key_filename" {
  type        = string
  default     = ""
  description = "The name the VCD UI Loadbalancer certificate key file. The file must be located in 'files/vcd-lb-cert/' folder, e.g. - cert.key."
}

variable "vcd_admin_username" {
  description = "VCD Administrator Username"
  default     = "vcd_admin"
}

variable "vcd_admin_email" {
  description = "VCD Administrator Email"
  default     = "vcd_admin@example.com"
}

variable "vcd_admin_password" {
  description = "VCD Administrator Password"
  default     = "VMware123!"
}

variable "vcd_system_name" {
  description = "VCD Instance Name"
  default     = ""
}

variable "vcd_serial_number" {
  description = "Serial number to license the VCD instalation"
  default     = ""
}
