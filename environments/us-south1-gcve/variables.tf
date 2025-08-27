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

variable "vpc_network_id" {
  type        = string
  default     = ""
  description = "VPC network ID to which the Peeringneeds to be established. ID needs to be in the following format - projects/{project}/global/networks/{vpcId}"
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

variable "edge_services_cidr" {
  description = "IP address range in CIDR notation used to create internet access and external IP access. An RFC 1918 CIDR block, with a /26 prefix, is required. The range cannot overlap with any prefixes either in the consumer VPC network or in use by the private clouds attached to that VPC network."
  type        = string
  default     = "172.17.0.0/26"
}

variable "internet_access_enabled" {
  description = "Enable Internet Access for Workload VMs."
  type = bool
  default = false
}

variable "external_ip_enabled" {
  description = "Network service that allows External IP addresses to be assigned to VMware workloads. This service can only be enabled when internetAccess is also enabled."
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

variable "prime_client_internal_ip" {
  description = "Prime Client internal IP Address."
  type = string
  default = ""
}
