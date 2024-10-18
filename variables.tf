variable "gcloud_project" {
  type        = string
  description = "GCloud project for this deployment."
  default     = ""
}

variable "gcloud_region" {
  default     = "us-west1"
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

variable "initial_vcd_cell_machine_type" {
  description = "Instance type for the Initial VCD cell"
  default     = "e2-medium"
}

variable "vcd_cells_machine_type" {
  description = "Instance type for the VCD cells"
  default     = "n2-standard-2"
}

variable "vcd_heap_size_max" {
  description = "Max Java Heap Size value in MB"
  default     = 4096
}

variable "image_family" {
  description = "Source image family."
  default     = "centos-stream-9"
}

variable "image_project" {
  description = "Project where the source image for the Bastion comes from"
  default     = "centos-cloud"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  default     = 20
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "target_ui_cells_number" {
  description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
  default     = 1
  type        = number
}

# variable "target_size_console" {
#   description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
#   default     = 1
#   type        = number
# }

variable "vcd_binary_filename" {
  type        = string
  default     = ""
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

variable "vcd_cert_private_key_password" {
  description = "vCD Certificate Private Key Password."
  default     = ""
}

variable "vcd_cert_private_key_file_decrypted" {
  type        = string
  default     = ""
  description = "vCD Certificate Private Decrypted Key file. The file must be located in 'files/vcd-cert-file/' folder, e.g. - vcd_cert_decrypted.key."
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

variable "transfer_store_size_gb" {
  description = "Filestore Mount capacity in GiB. This must be at least 1024 GiB for the standard tier, or 2560 GiB for the premium tier."
  default     = 1024
}

###### GCVE Variables

variable "gcve_network_name" {
  description = "Name for the GCVE netowrk to be created"
  default     = ""
}

variable "gcve_vpc_peering" {
  description = "Enable VPC peering."
  type = bool
  default = false
}

####### GCVE SDDC Variables
variable "gcve_sddc_variables" {
  type = list(object({
    enabled = bool
    sddc_name = string
    sddc_zone = string
    sddc_cluster_name = string
    sddc_node_type_id = string
    sddc_node_count = number
    sddc_mgmt_subnet_cidr = string
    sddc_workload_subnet =  bool
    sddc_workload_subnet_name = string
    sddc_workload_subnet_cidr = string
  }))
  default = [
  {
    enabled = false
    sddc_name = "sddc1"
    sddc_zone = "us-west4"
    sddc_cluster_name = "sddc1-cluster"
    sddc_node_type_id = "ve1-standard-72"
    sddc_node_count = 3
    sddc_mgmt_subnet_cidr = "10.0.0.0/23"
    sddc_workload_subnet =  false
    sddc_workload_subnet_name = "workload-net1"
    sddc_workload_subnet_cidr = "10.0.2.0/23"
  },
  ]
}
