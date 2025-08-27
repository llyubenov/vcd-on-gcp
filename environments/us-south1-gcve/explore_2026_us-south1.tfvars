gcloud_project  = "dvcf01-hol-gcve"
gcloud_region   = "us-south1"
# gcloud_subnet_cidr = "172.16.0.0/24"
# bastion_members = [
#     "user:lyubomir.lyubenov@broadcom.com",
#     "user:brandon.bazan@broadcom.com",
#     "terraform@dvcf01-hol-gcve.iam.gserviceaccount.com"
# ]
# transfer_store_size_gb = 8192
# initial_vcd_cell_machine_type = "n2d-standard-2"
# vcd_cells_machine_type = "n2d-standard-4"
# vcd_heap_size_max = 12288
# image_family = "centos-stream-9"
# disk_size_gb =  20
# disk_type = "pd-standard"
# target_ui_cells_number = 3
# vcd_binary_filename = "vmware-vcloud-director-distribution-10.6.1-24756346.bin"
# vcd_cert_file = "hol_dev_vmware_com.pem"
# vcd_cert_private_key_file = "hol_dev_vmware_com_encrypted.key"
# vcd_cert_private_key_password = "VMware123!"
# vcd_cert_private_key_file_decrypted = "hol_dev_vmware_com.key"
# vcd_admin_username = "vcd_admin"
# vcd_admin_password = "VMware123!"
# vcd_system_name = "us-south1-vcd01"
# vcd_serial_number = "100RK-AJ20N-089N9-0H822-35UK3"


##### GCVE Varibles #####
gcve_network_name = "explore-sddc-network-us-south1"
gcve_vpc_peering  = true
vpc_network_id = "projects/dvcf01-hol-gcve/global/networks/vcd-net-us-south1"
edge_services_cidr = "172.17.0.0/26"
internet_access_enabled = true
external_ip_enabled = true


####### GCVE SDDC Variables
gcve_sddc_variables = [
  {
    enabled = true
    sddc_name = "us-south1-sddc1"
    sddc_zone = "us-south1-b"
    sddc_cluster_name = "us-south1-sddc1-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 20
    sddc_mgmt_subnet_cidr = "10.0.0.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.0.2.0/23"
  },
  {
    enabled = true
    sddc_name = "us-south1-sddc2"
    sddc_zone = "us-south1-b"
    sddc_cluster_name = "us-south1-sddc2-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 20
    sddc_mgmt_subnet_cidr = "10.0.4.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.0.6.0/23"
  },
  {
    enabled = true
    sddc_name = "us-south1-sddc3"
    sddc_zone = "us-south1-b"
    sddc_cluster_name = "us-south1-sddc3-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 20
    sddc_mgmt_subnet_cidr = "10.0.8.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.0.10.0/23"
  },
  {
    enabled = true
    sddc_name = "us-south1-sddc4"
    sddc_zone = "us-south1-b"
    sddc_cluster_name = "us-south1-sddc4-cl01"
    sddc_node_type_id = "standard-72"
    sddc_node_count = 24
    sddc_mgmt_subnet_cidr = "10.0.12.0/22"
    sddc_workload_subnet =  false
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.0.16.0/23"
  }
]

####### Prime Client Variables
prime_client_internal_ip = "192.168.17.251"
