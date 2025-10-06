include "root" {
    path = find_in_parent_folders("root.hcl")
    expose = true
}

terraform {
    source = "../../../../modules/gcve-private-cloud"
}

inputs = {
    gcve_network_id = "projects/${include.root.locals.project}/locations/global/vmwareEngineNetworks/${include.root.locals.gcve_network_name}"
    sddc_name = "us-west2-sddc6"
    sddc_zone = "us-west2-a"
    sddc_cluster_name = "us-west2-sddc6-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 4
    sddc_mgmt_subnet_cidr = "10.1.28.0/22"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.1.32.0/23"
}
