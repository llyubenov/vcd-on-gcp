gcloud_project  = "dvcf01-hol-gcve"
gcloud_region   = "us-south1"
gcloud_subnet_cidr = "172.16.0.0/24"
bastion_members = [
    "user:lyubomir.lyubenov@broadcom.com",
    "user:brandon.bazan@broadcom.com",
    "terraform@dvcf01-hol-gcve.iam.gserviceaccount.com"
]

##### Cloud SQL Variables
pgdb_version = "POSTGRES_15"
pgdb_tier = "db-custom-8-32768"
pgdb_availability_type = "REGIONAL"
sql_deletion_protection = true

##### VCD Variables
transfer_store_size_gb = 8192
initial_vcd_cell_machine_type = "n2d-standard-2"
vcd_cells_machine_type = "n2d-standard-4"
vcd_heap_size_max = 12288
image_family = "centos-stream-9"
disk_size_gb =  20
disk_type = "pd-standard"
target_ui_cells_number = 5
vcd_binary_filename = "vmware-vcloud-director-distribution-10.6.1-24756346.bin"
vcd_cert_file = "hol_dev_vmware_com.pem"
vcd_cert_private_key_file = "hol_dev_vmware_com_encrypted.key"
vcd_cert_private_key_password = "VMware123!"
vcd_cert_private_key_file_decrypted = "hol_dev_vmware_com.key"
vcd_admin_username = "vcd_admin"
vcd_admin_password = "VMware123!"
vcd_system_name = "us-south1-vcd01"
vcd_serial_number = "100RK-AJ20N-089N9-0H822-35UK3"


##### GCVE Varibles #####
gcve_network_name = "explore-sddc-network-us-south1"
gcve_vpc_peering  = true

####### GCVE SDDC Variables
gcve_sddc_variables = [
  {
    enabled = false
    sddc_name = "explore-sddc1"
    sddc_zone = "europe-west3-b"
    sddc_cluster_name = "explore-sddc1-cl01"
    sddc_node_type_id = "standard-128"
    sddc_node_count = 12
    sddc_mgmt_subnet_cidr = "10.0.0.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.0.2.0/23"
  },
  {
    enabled = false
    sddc_name = "explore-sddc2"
    sddc_zone = "europe-west3-b"
    sddc_cluster_name = "explore-sddc2-cl01"
    sddc_node_type_id = "standard-128"
    sddc_node_count = 12
    sddc_mgmt_subnet_cidr = "10.0.4.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.0.6.0/23"
  },
  {
    enabled = false
    sddc_name = "explore-sddc3"
    sddc_zone = "europe-west3-b"
    sddc_cluster_name = "explore-sddc3-cl01"
    sddc_node_type_id = "standard-128"
    sddc_node_count = 12
    sddc_mgmt_subnet_cidr = "10.0.8.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.0.10.0/23"
  },
  {
    enabled = true
    sddc_name = "explore-sddc4"
    sddc_zone = "europe-west3-b"
    sddc_cluster_name = "explore-sddc4-cl01"
    sddc_node_type_id = "standard-128"
    sddc_node_count = 12
    sddc_mgmt_subnet_cidr = "10.0.12.0/23"
    sddc_workload_subnet =  true
    sddc_workload_subnet_name = "service-1"
    sddc_workload_subnet_cidr = "10.0.14.0/23"
  }
]

