output filestore-ip-address {
  value       = google_filestore_instance.vcd-transfer-store.networks.0.ip_addresses.0
  description = "IP address of Filstore export"
}
