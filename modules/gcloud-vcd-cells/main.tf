data "google_compute_image" "vcd_image" {
  family  = var.image_family
  project = var.image_project
}

data "template_file" "initial-vcd-cell-script" {
  template = file("${path.root}/scripts/initial-vcd-cell-init.sh")
  vars = {
    vcd_ui_ip                      = var.vcd_ui_ip
    bucket_url                     = var.bucket_url
    vcd_binary_filename            = var.vcd_binary_filename
    vcd_db_instance_ip             = var.vcd_db_instance_ip
    vcd_db_name                    = var.vcd_db_name
    vcd_db_username                = var.vcd_db_username
    vcd_db_username_password       = var.vcd_db_username_password
    vcd_keystore_filename          = var.vcd_keystore_filename
    vcd_keystore_filename_password = var.vcd_keystore_filename_password
    vcd_admin_username             = var.vcd_admin_username
    vcd_admin_fullname             = var.vcd_admin_fullname
    vcd_admin_email                = var.vcd_admin_email
    vcd_admin_password             = var.vcd_admin_password
    vcd_system_name                = var.vcd_system_name
    vcd_installation_id            = var.vcd_installation_id
    vcd_serial_number              = var.vcd_serial_number
    transfer_mount_ip              = var.transfer_mount_ip
    transfer_mount_name            = var.transfer_mount_name
  }
}

data "template_file" "vcd-cells-script" {
  template = file("${path.root}/scripts/vcd-cells-init-mig.sh")
  vars = {
    bucket_url                     = var.bucket_url
    vcd_binary_filename            = var.vcd_binary_filename
    vcd_keystore_filename          = var.vcd_keystore_filename
    vcd_keystore_filename_password = var.vcd_keystore_filename_password
    transfer_mount_ip              = var.transfer_mount_ip
    transfer_mount_name            = var.transfer_mount_name
  }
}

resource "google_compute_instance" "first-vcd-cell" {
  name         = var.initial_vcd_cell_name
  machine_type = var.initial_vcd_cell_machine_type
  zone         = "${var.region}-a"

  tags = var.tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.vcd_image.self_link
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = data.template_file.initial-vcd-cell-script.rendered

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
  }
}

resource "time_sleep" "wait_5_minutes" {
  create_duration = "5m"
  depends_on      = [google_compute_instance.first-vcd-cell]
}

resource "google_compute_instance_template" "vcd-cells" {
  name_prefix          = var.vcd_cells_name_prefix
  machine_type         = var.vcd_cells_machine_type
  region               = var.region
  tags                 = var.tags

  disk {
    source_image = data.google_compute_image.vcd_image.self_link
    auto_delete  = true
    boot         = true
    disk_type    = var.disk_type
    disk_size_gb = var.disk_size_gb
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = data.template_file.vcd-cells-script.rendered

  lifecycle {
    create_before_destroy = true
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

module "mig_ui" {
  source  = "terraform-google-modules/vm/google//modules/mig"

  project_id        = var.project
  region            = var.region
  target_size       = var.target_size_ui
  hostname          = "${var.vcd_cells_name_prefix}-ui"
  health_check      = var.health_check
  named_ports       = var.named_ports_ui
  instance_template = google_compute_instance_template.vcd-cells.self_link

  depends_on        = [time_sleep.wait_5_minutes]
}

# module "mig_console" {
#   source  = "terraform-google-modules/vm/google//modules/mig"

#   project_id        = var.project
#   region            = var.region
#   target_size       = var.target_size_console
#   hostname          = "${var.vcd_cells_name_prefix}-console"
#   health_check      = var.health_check
#   named_ports       = var.named_ports_console
#   instance_template = google_compute_instance_template.vcd-cells.self_link

#   depends_on        = [time_sleep.wait_5_minutes]
# }