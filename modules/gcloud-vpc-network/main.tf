resource "google_compute_global_address" "vcd-ui-ip" {
  name         = "vcd-ui-address"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_global_address" "vcd-console-ip" {
  name         = "vcd-console-address"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_network" "vcd-network" {
  name                    = "vcd-network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_router" "vcd-cloud-router" {
  name              = "vcd-cloud-router"
  network           = google_compute_network.vcd-network.name
  region            = var.region
}

resource "google_compute_router_nat" "vcd-cloud-nat" {
  name                               = "vcd-cloud-nat"
  router                             = google_compute_router.vcd-cloud-router.name
  region                             = google_compute_router.vcd-cloud-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.vcd-subnetwork.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_subnetwork" "vcd-subnetwork" {
  name          = "vcd-subnetwork"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vcd-network.id 
}

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.vcd-network.id
}

resource "google_service_networking_connection" "servicenetworking-googleapis-com" {
  network                 = google_compute_network.vcd-network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

resource "google_compute_firewall" "inbound-ssh" {
  name        = "allow-inbound-ssh"
  network     = google_compute_network.vcd-network.name

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }

  source_tags = ["bastion"]
  target_tags = ["vcd-cells"]
}

resource "google_compute_firewall" "intra-vcd-comms" {
  name        = "intra-vcd-comms"
  network     = google_compute_network.vcd-network.name

  allow {
    protocol  = "all"
  }

  source_tags = ["vcd-cells"]
  target_tags = ["vcd-cells"]
}

resource "google_compute_firewall" "transfer-store" {
  name        = "transfer-store"
  network     = google_compute_network.vcd-network.name

  allow {
    protocol  = "tcp"
    ports     = ["111", "920", "2049"]
  }

  allow {
    protocol  = "udp"
    ports     = ["111", "920", "2049"]
  }

  source_tags = ["transfer-store"]
  target_tags = ["vcd-cells"]
}

resource "google_compute_firewall" "vcd-healthcheck" {
  name       = "vcd-healthcheck"
  network    = google_compute_network.vcd-network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_tags = ["vcd-cells"]
}

resource "google_compute_firewall" "vcd-lb-access" {
  name       = "vcd-lb-access"
  network    = google_compute_network.vcd-network.name

  allow {
    protocol = "tcp"
    ports    = ["443", "8443"]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_tags = ["vcd-cells"]
}