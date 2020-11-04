resource "google_filestore_instance" "vcd-transfer-store" {
  name = "vcd-transfer-store"
  zone = "${var.region}-a"
  tier = "BASIC_HDD"

  file_shares {
    capacity_gb = 1024
    name        = var.transfer_mount_name
  }

  networks {
    network = var.network
    modes   = ["MODE_IPV4"]
  }
}