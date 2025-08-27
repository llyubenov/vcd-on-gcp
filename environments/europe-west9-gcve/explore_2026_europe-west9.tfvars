gcloud_project  = "dvcf01-hol-gcve"
gcloud_region   = "europe-west9"

##### GCVE Varibles #####
gcve_network_name = "sddc-network-europe-west9"
gcve_vpc_peering  = true
vpc_network_id = "projects/dvcf01-hol-gcve/global/networks/vcd-net-europe-west9"
edge_services_cidr = "172.17.0.128/26"
internet_access_enabled = true
external_ip_enabled = true

####### GCVE SDDC Variables
gcve_sddc_variables = [
  {
    enabled = true
    sddc_name = "europe-west9-sddc1"
    sddc_zone = "europe-west9-b"
    sddc_cluster_name = "europe-west9-sddc1-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 20
    sddc_mgmt_subnet_cidr = "10.2.0.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.2.2.0/23"
  },
  {
    enabled = true
    sddc_name = "europe-west9-sddc2"
    sddc_zone = "europe-west9-b"
    sddc_cluster_name = "europe-west9-sddc2-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 20
    sddc_mgmt_subnet_cidr = "10.2.4.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.2.6.0/23"
  },
  {
    enabled = true
    sddc_name = "europe-west9-sddc3"
    sddc_zone = "europe-west9-b"
    sddc_cluster_name = "europe-west9-sddc3-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 20
    sddc_mgmt_subnet_cidr = "10.2.8.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.2.10.0/23"
  },
  {
    enabled = true
    sddc_name = "europe-west9-sddc4"
    sddc_zone = "europe-west9-b"
    sddc_cluster_name = "europe-west9-sddc4-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 25
    sddc_mgmt_subnet_cidr = "10.2.12.0/22"
    sddc_workload_subnet =  false
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.2.16.0/23"
  }
]

prime_client_internal_ip = "192.168.21.251"
