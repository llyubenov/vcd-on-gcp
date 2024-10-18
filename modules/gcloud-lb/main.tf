# data "google_compute_global_address" "vcd-ui-ip" {
#   name = "vcd-ui-address"
# }

# data "google_compute_global_address" "vcd-console-ip" {
#   name = "vcd-console-address"
# }

resource "google_compute_ssl_certificate" "vcd-ui" {
  name        = "vcd-ui"
  private_key = file("${path.root}/files/vcd-cert-file/${var.lb_cert_key_filename}")
  certificate = file("${path.root}/files/vcd-cert-file/${var.lb_cert_filename}")

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_url_map" "vcd-ui" {
  name            = "vcd-ui"
  default_service = google_compute_backend_service.vcd-ui.id
}

resource "google_compute_global_forwarding_rule" "vcd-ui-https" {
  name       = "vcd-ui-https-rule"
  target     = google_compute_target_https_proxy.vcd-ui-https.self_link
  ip_address = var.vcd_ui_ip
  port_range = "443"
}

# resource "google_compute_global_forwarding_rule" "vcd-console-tcp" {
#   name       = "vcd-console-tcp-rule"
#   target     = google_compute_target_tcp_proxy.vcd-console-tcp.self_link
#   ip_address = var.vcd_console_ip
#   port_range = "443"
# }

resource "google_compute_target_https_proxy" "vcd-ui-https" {
  name    = "vcd-ui-https-proxy"
  url_map = google_compute_url_map.vcd-ui.id

  ssl_certificates = [google_compute_ssl_certificate.vcd-ui.id]
}

# resource "google_compute_target_tcp_proxy" "vcd-console-tcp" {
#   name            = "vcd-console-tcp-proxy"
#   backend_service = google_compute_backend_service.vcd-console.id
# }

resource "google_compute_backend_service" "vcd-ui" {
  name                            = "vcd-ui-backend"
  port_name                       = "https"
  protocol                        = "HTTPS"
  timeout_sec                     = null
  connection_draining_timeout_sec = null
  enable_cdn                      = false
  security_policy                 = null
  health_checks                   = [google_compute_health_check.vcd-health-check.id]
  session_affinity                = null
  affinity_cookie_ttl_sec         = null
  custom_request_headers          = null
  load_balancing_scheme           = "EXTERNAL"

  backend {
    balancing_mode               = "UTILIZATION"
    group                        = var.vcd_ui_mig
  }
  

  log_config {
    enable      = true
    sample_rate = "1.0"
  }

  depends_on = [google_compute_health_check.vcd-health-check]

}

# resource "google_compute_backend_service" "vcd-console" {
#   name                            = "vcd-console-backend"
#   port_name                       = "tcp"
#   protocol                        = "TCP"
#   timeout_sec                     = null
#   connection_draining_timeout_sec = null
#   enable_cdn                      = false
#   security_policy                 = null
#   health_checks                   = [google_compute_health_check.vcd-health-check.id]
#   session_affinity                = null
#   affinity_cookie_ttl_sec         = null
#   custom_request_headers          = null
#   load_balancing_scheme           = "EXTERNAL"

#   backend {
#     balancing_mode               = "UTILIZATION"
#     group                        = var.vcd_console_mig
#   }
  

#   log_config {
#     enable      = true
#     sample_rate = "1.0"
#   }

#   depends_on = [google_compute_health_check.vcd-health-check]

# }

resource "google_compute_health_check" "vcd-health-check" {
  name        = "vcd-health-check"
  description = "Health check via http"

  timeout_sec         = 5
  check_interval_sec  = 10
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port               = 80
    host               = ""
    request_path       = "/api/server_status"
    proxy_header       = "NONE"
    response           = "Service is up."
  }
}
