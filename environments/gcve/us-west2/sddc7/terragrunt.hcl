include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
    source = "../../../../modules/gcve-private-cloud"
}

inputs = {
    gcve_network_name = "sddc-network-us-west2"
    sddc_name = "us-west2-sddc7"
    sddc_zone = "us-west2-a"
    sddc_cluster_name = "us-west2-sddc7-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 4
    sddc_mgmt_subnet_cidr = "10.1.36.0/22"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.1.40.0/23"
}
