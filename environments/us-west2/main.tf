provider "google" {
  credentials         = file("../../credentials/dvcf01-hol-gcve-b3748fb3c9ec.json")
  project             = var.gcloud_project
}
provider "google-beta" {
  credentials         = file("../../credentials/dvcf01-hol-gcve-b3748fb3c9ec.json")
  project             = var.gcloud_project
}

module "gcloud-storage" {
  source                = "../../modules/gcloud-storage"
  region                = var.gcloud_region
  vcd_binary_filename   = var.vcd_binary_filename
  vcd_cert_file                  = var.vcd_cert_file
  vcd_cert_private_key_file      = var.vcd_cert_private_key_file
}

module "gcloud-vpc-network" {
  source             = "../../modules/gcloud-vpc-network"
  region             = var.gcloud_region
  subnet_cidr        = var.gcloud_subnet_cidr
}

module "gcloud-filestore" {
  source             = "../../modules/gcloud-filestore"
  region             = var.gcloud_region
  network            = module.gcloud-vpc-network.vcd-network
  transfer_store_size_gb = var.transfer_store_size_gb
}

module "gloud-sql" {
  source                  = "../../modules/gcloud-sql"
  depends_on              = [module.gcloud-vpc-network]
  region                  = var.gcloud_region
  network                 = module.gcloud-vpc-network.vcd-network-id
  pgdb_version            = var.pgdb_version
  pgdb_tier               = var.pgdb_tier
  pgdb_availability_type  = var.pgdb_availability_type
  sql_deletion_protection = var.sql_deletion_protection
}

module "bastion-vm" {
  source             = "../../modules/gcloud-bastion"
  target_size        = 1
  image_family       = var.image_family
  image_project      = var.image_project
  tags               = ["bastion"]
  machine_type       = "e2-medium"
  name               = "bastion-vm-${var.gcloud_region}"
  project            = var.gcloud_project
  region             = var.gcloud_region
  zone               = "${var.gcloud_region}-a"
  network            = module.gcloud-vpc-network.vcd-network-self-link
  subnet             = module.gcloud-vpc-network.vcd-subnetwork-self-link
  disk_size_gb       = 20
  disk_type          = "pd-standard"
  startup_script     = file("${path.module}/../../files/scripts/bastion-init.sh")
  service_account_name = "bastion-group-${var.gcloud_region}"
  fw_name_allow_ssh_from_health_check_cidrs = "allow-ssh-from-health-check-cidrs-${var.gcloud_region}"
  fw_name_allow_ssh_from_iap = "allow-ssh-from-iap-to-bastion-group-${var.gcloud_region}"
}

module "vcd-cells" {
  source                         = "../../modules/gcloud-vcd-cells"
  project                        = var.gcloud_project
  tags                           = ["vcd-cells"]
  region                         = var.gcloud_region
  target_ui_cells_number         = var.target_ui_cells_number
  network                        = module.gcloud-vpc-network.vcd-network
  subnetwork                     = module.gcloud-vpc-network.vcd-subnetwork
  initial_vcd_cell_machine_type  = var.initial_vcd_cell_machine_type
  vcd_cells_machine_type         = var.vcd_cells_machine_type
  image_family                   = var.image_family
  image_project                  = var.image_project
  disk_size_gb                   = var.disk_size_gb
  disk_type                      = var.disk_type
  vcd_heap_size_max              = var.vcd_heap_size_max
  vcd_ui_ip                      = module.gcloud-vpc-network.vcd-ui-ip
  bucket_url                     = module.gcloud-storage.bucket-url
  vcd_binary_filename            = var.vcd_binary_filename
  vcd_db_instance_ip             = module.gloud-sql.vcddb-private-ip-address
  vcd_db_name                    = module.gloud-sql.vcddb-name
  vcd_db_username                = module.gloud-sql.vcddb-username
  vcd_db_username_password       = module.gloud-sql.vcddb-username-password
  vcd_cert_file                  = var.vcd_cert_file
  vcd_cert_private_key_file      = var.vcd_cert_private_key_file
  vcd_cert_private_key_password  = var.vcd_cert_private_key_password
  vcd_admin_username             = var.vcd_admin_username
  vcd_admin_email                = var.vcd_admin_email
  vcd_admin_password             = var.vcd_admin_password
  vcd_system_name                = var.vcd_system_name
  vcd_serial_number              = var.vcd_serial_number
  transfer_mount_ip              = module.gcloud-filestore.filestore-ip-address
  }

  module "gcloud-lb" {
  source               = "../../modules/gcloud-lb"
  lb_cert_filename     = var.vcd_cert_file
  lb_cert_key_filename = var.vcd_cert_private_key_file_decrypted
  vcd_ui_ip            = module.gcloud-vpc-network.vcd-ui-ip
  vcd_ui_mig           = module.vcd-cells.vcd-ui-mig
  region               = var.gcloud_region
  }

