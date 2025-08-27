gcloud_project  = "dvcf01-hol-gcve"
gcloud_region   = "europe-west9"
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
vcd_system_name = "europe-west9-vcd01"
vcd_serial_number = "100RK-AJ20N-089N9-0H822-35UK3"
