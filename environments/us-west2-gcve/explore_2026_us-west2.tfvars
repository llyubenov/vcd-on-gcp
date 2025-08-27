gcloud_project  = "dvcf01-hol-gcve"
gcloud_region   = "us-west2"

##### GCVE Varibles #####
gcve_network_name = "sddc-network-us-west2"
gcve_vpc_peering  = true
vpc_network_id = "projects/dvcf01-hol-gcve/global/networks/vcd-net-us-west2"
edge_services_cidr = "172.17.0.64/26"
internet_access_enabled = true
external_ip_enabled = true

####### GCVE SDDC Variables
gcve_sddc_variables = [
  {
    enabled = true
    sddc_name = "us-west2-sddc1"
    sddc_zone = "us-west2-a"
    sddc_cluster_name = "us-west2-sddc1-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 20
    sddc_mgmt_subnet_cidr = "10.1.0.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.1.2.0/23"
  },
  {
    enabled = true
    sddc_name = "us-west2-sddc2"
    sddc_zone = "us-west2-a"
    sddc_cluster_name = "us-west2-sddc2-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 6
    sddc_mgmt_subnet_cidr = "10.1.4.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.1.6.0/23"
  },
  {
    enabled = true
    sddc_name = "us-west2-sddc3"
    sddc_zone = "us-west2-a"
    sddc_cluster_name = "us-west2-sddc3-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 20
    sddc_mgmt_subnet_cidr = "10.1.8.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.1.10.0/23"
  },
  {
    enabled = true
    sddc_name = "us-west2-sddc4"
    sddc_zone = "us-west2-a"
    sddc_cluster_name = "us-west2-sddc4-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 16
    sddc_mgmt_subnet_cidr = "10.1.12.0/22"
    sddc_workload_subnet =  false
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.1.16.0/23"
  }
]

prime_client_internal_ip = "192.168.41.251"
