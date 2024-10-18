resource "google_filestore_instance" "vcd-transfer-store" {
  name = "vcd-transfer-store"
  location = "${var.region}-a"
  tier = "BASIC_HDD"

  file_shares {
    capacity_gb = var.transfer_store_size_gb
    name        = var.transfer_mount_name
  }

  networks {
    network = var.network
    modes   = ["MODE_IPV4"]
  }
}
