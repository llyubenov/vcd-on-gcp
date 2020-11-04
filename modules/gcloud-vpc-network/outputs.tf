output vcd-ui-ip {
  value       = google_compute_global_address.vcd-ui-ip.address
  description = "VCD UI Load Balancer IP"
}

output vcd-console-ip {
  value       = google_compute_global_address.vcd-console-ip.address
  description = "VCD Console Load Balancer IP"
}

output vcd-network {
  value       = google_compute_network.vcd-network.name
  description = "VCD Network"
}

output vcd-network-id {
  value       = google_compute_network.vcd-network.id
  description = "VCD Network ID"
}

output vcd-network-self-link {
  value       = google_compute_network.vcd-network.self_link 
  description = "VCD Network URI"
}

output vcd-subnetwork {
  value       = google_compute_subnetwork.vcd-subnetwork.name
  description = "VCD Subnetwork"
}

output vcd-subnetwork-id {
  value       = google_compute_subnetwork.vcd-subnetwork.id
  description = "VCD Subnetwork ID"
}

output vcd-subnetwork-self-link {
  value       = google_compute_subnetwork.vcd-subnetwork.self_link 
  description = "VCD Subnetwork URI"
}
