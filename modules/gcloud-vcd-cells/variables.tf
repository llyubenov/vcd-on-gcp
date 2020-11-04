variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  description = "The GCP region where the vcd instances resides."
}

variable "target_size_ui" {
  description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
  default     = 1
}

variable "target_size_console" {
  description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
  default     = 1
}

variable "image_family" {
  description = "Source image family."
  default     = "centos-8"
}

variable "image_project" {
  description = "Project where the source image comes from"
  default     = "centos-cloud"
}

variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = ["vcd-cells"]
}

variable "vcd_ui_ip" {
  description = "VCD UI Load Balancer IP"
}

variable "initial_vcd_cell_machine_type" {
  description = "Instance type for the Initial VCD cell"
  default     = "e2-medium"
}

variable "vcd_cells_machine_type" {
  description = "Instance type for the VCD cells"
  default     = "n2-standard-2"
}

variable "initial_vcd_cell_name" {
  description = "Name of the initial VCD cell instance"
  default     = "initial-vcd-cell"
}

variable "vcd_cells_name_prefix" {
  description = "Name prefix of VCD cells instances"
  default     = "vcd-cells"
}

variable "network" {
  description = "Name or Self link for the network on which the VCD cells should live"
}

variable "subnetwork" {
  description = "Name or Self link for the subnetwork on which the VCD cells should live"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  default     = 20
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "startup_script" {
  description = "Render a startup script with a template."
  default     = ""
}

variable "named_ports_ui" {
  description = "Named name and named port. https://cloud.google.com/load-balancing/docs/backend-service#named_ports"
  type = list(object({
    name = string
    port = number
  }))
  default = [
    {
      name = "https"
      port = 443
    }
  ]
}

variable "named_ports_console" {
  description = "Named name and named port. https://cloud.google.com/load-balancing/docs/backend-service#named_ports"
  type = list(object({
    name = string
    port = number
  }))
  default = [
    {
      name = "tcp"
      port = 8443
    }
  ]
}

variable "bucket_url" {
  description = "Bucket URL for whent he VCD binary and the VCD Java keystore file reside. - gs://<bucket-name>"
  default     = ""
}

variable "vcd_binary_filename" {
  description = "The IP addres of the VCD DB Postgres SQL Instance"
  default     = ""
}

variable "vcd_db_instance_ip" {
  description = "The IP addres of the VCD DB Postgres SQL Instance"
  default     = ""
}

variable "vcd_db_name" {
  description = "The Name of the VCD DB"
  default     = ""
}

variable "vcd_db_username" {
  description = "VCD DB Postgres SQL Username"
  default     = ""
}

variable "vcd_db_username_password" {
  description = "VCD DB Postgres SQL Username Password"
  default     = ""
}

variable "vcd_keystore_filename" {
  description = "VCD Java Keystore filename"
  default     = "certificates.ks"
}

variable "vcd_keystore_filename_password" {
  description = "VCD Java Keystore filename password"
  default     = ""
}

variable "vcd_admin_username" {
  description = "VCD Administrator Username"
  default     = "vcd_admin"
}

variable "vcd_admin_fullname" {
  description = "VCD Administrator Full name"
  default     = "VCD System Administrator"
}

variable "vcd_admin_email" {
  description = "VCD Administrator Email"
  default     = "vcd_admin@example.com"
}

variable "vcd_admin_password" {
  description = "VCD Administrator Password"
  default     = ""
}

variable "vcd_system_name" {
  description = "VCD Instance Name"
  default     = ""
}

variable "vcd_installation_id" {
  description = "The installation ID for this installation of vCloud Director. The system uses the installation ID when generating MAC addresses for virtual NICs. An integer in the range 1-63."
  default     = 1
}

variable "vcd_serial_number" {
  description = "Serial number to license the VCD instalation"
  default     = ""
}

variable "transfer_mount_ip" {
  description = "Filestore IP address that will be used for VCd Transfer Store"
  default     = ""
}

variable "transfer_mount_name" {
  description = "Filestore Mount name that will be used for VCd Transfer Store"
  default     = "xfer"
}

##############
# Healthcheck
##############

variable "health_check" {
  description = "Health check to determine whether instances are responsive and able to do work"
  type = object({
    type                = string
    initial_delay_sec   = number
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    response            = string
    proxy_header        = string
    port                = number
    request             = string
    request_path        = string
    host                = string
  })
  default = {
    type                = "http"
    initial_delay_sec   = 240
    check_interval_sec  = 10
    healthy_threshold   = 2
    timeout_sec         = 5
    unhealthy_threshold = 3
    response            = "Service is up."
    proxy_header        = "NONE"
    port                = 80
    request             = ""
    request_path        = "/api/server_status"
    host                = ""
  }
}