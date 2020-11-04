provider "google" {
  credentials         = file("vlp-poc-credentials.json")
  project             = var.gcloud_project
}

module "gcloud-storage" {
  source                = "./modules/gcloud-storage"
  region                = var.gcloud_region
  vcd_binary_filename   = var.vcd_binary_filename
  vcd_keystore_filename = var.vcd_keystore_filename
}

module "gcloud-vpc-network" {
  source             = "./modules/gcloud-vpc-network"
  region             = var.gcloud_region
  subnet_cidr        = var.gcloud_subnet_cidr
}

module "gcloud-filestore" {
  source             = "./modules/gcloud-filestore"
  region             = var.gcloud_region
  network            = module.gcloud-vpc-network.vcd-network
}

module "gloud-sql" {
  source                  = "./modules/gcloud-sql"
  depends_on              = [module.gcloud-vpc-network]
  region                  = var.gcloud_region
  network                 = module.gcloud-vpc-network.vcd-network-id
  sql_deletion_protection = var.sql_deletion_protection
}

module "bastion-vm" {
  source             = "./modules/gcloud-bastion"
  target_size        = 1
  image_family       = "centos-7"
  tags               = ["bastion"]
  machine_type       = "n1-standard-1"
  name               = "bastion-vm"
  project            = var.gcloud_project
  region             = var.gcloud_region
  zone               = "${var.gcloud_region}-a"
  network            = module.gcloud-vpc-network.vcd-network-self-link
  subnet             = module.gcloud-vpc-network.vcd-subnetwork-self-link
  disk_size_gb       = 20
  disk_type          = "pd-standard"
  startup_script     = file("${path.module}/scripts/bastion-init.sh")
}

module "vcd-cells" {
  source                         = "./modules/gcloud-vcd-cells"
  project                        = var.gcloud_project
  tags                           = ["vcd-cells"]
  region                         = var.gcloud_region
  target_size_ui                 = var.target_size_ui
  target_size_console            = var.target_size_console
  network                        = module.gcloud-vpc-network.vcd-network
  subnetwork                     = module.gcloud-vpc-network.vcd-subnetwork
  initial_vcd_cell_machine_type  = "e2-medium"
  vcd_cells_machine_type         = "n2-standard-4"
  image_family                   = "centos-8"
  disk_size_gb                   = 20
  disk_type                      = "pd-standard"
  vcd_ui_ip                      = module.gcloud-vpc-network.vcd-ui-ip
  bucket_url                     = module.gcloud-storage.bucket-url
  vcd_binary_filename            = var.vcd_binary_filename
  vcd_db_instance_ip             = module.gloud-sql.vcddb-private-ip-address
  vcd_db_name                    = module.gloud-sql.vcddb-name
  vcd_db_username                = module.gloud-sql.vcddb-username
  vcd_db_username_password       = module.gloud-sql.vcddb-username-password
  vcd_keystore_filename          = var.vcd_keystore_filename
  vcd_keystore_filename_password = var.vcd_keystore_filename_password
  vcd_admin_username             = var.vcd_admin_username
  vcd_admin_email                = var.vcd_admin_email
  vcd_admin_password             = var.vcd_admin_password
  vcd_system_name                = var.vcd_system_name
  vcd_serial_number              = var.vcd_serial_number
  transfer_mount_ip              = module.gcloud-filestore.filestore-ip-address
  }

  module "gcloud-lb" {
  source               = "./modules/gcloud-lb"
  lb_cert_filename     = var.lb_cert_filename
  lb_cert_key_filename = var.lb_cert_key_filename
  vcd_ui_ip            = module.gcloud-vpc-network.vcd-ui-ip
  vcd_console_ip       = module.gcloud-vpc-network.vcd-console-ip
  vcd_ui_mig           = module.vcd-cells.vcd-ui-mig
  vcd_console_mig           = module.vcd-cells.vcd-console-mig
  }