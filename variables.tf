variable "gcloud_project" {
  description = "GCloud project for this deployment."
  default     = "vlp-poc"
}

variable "gcloud_region" {
  default     = "us-east4"
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
}

variable "target_size_console" {
  description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
  default     = 1
}

variable "vcd_binary_filename" {
  type        = string
  default     = "vmware-vcloud-director-distribution-10.2.0-17029810.bin"
  description = "The VCD binary to be uploaded to the GCloud Storage Bucket. The binary file must be located in 'files/vcd-binaries/' folder."
}

variable "vcd_keystore_filename" {
  type        = string
  default     = "certificates.ks"
  description = "The VCD Java Keytool Certificate file to be uploaded to the GCloud Storage Bucket. The java keystoire file must be located in 'files/vcd-cert-file/' folder."
}

variable "lb_cert_filename" {
  type        = string
  default     = "star_test_vmwlp_com.crt"
  description = "The path to the VCD UI Loadbalancer certificate file. The file must be located in 'files/vcd-lb-cert/' folder, e.g. - files/vcd-lb-cert/cert.crt."
}

variable "lb_cert_key_filename" {
  type        = string
  default     = "star_test_vmwlp_com.key"
  description = "The path to the VCD UI Loadbalancer certificate key file. The file must be located in 'files/vcd-lb-cert/' folder, e.g. - files/vcd-lb-cert/cert.key."
}

variable "vcd_keystore_filename_password" {
  description = "VCD Java Keystore filename password"
  default     = "7BAG5qj*VKn&n3"
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
  default     = "gcp-test1"
}

variable "vcd_serial_number" {
  description = "Serial number to license the VCD instalation"
  default     = "100RK-AJ20N-089N9-0H822-35UK3"
}
