resource "random_id" "vcd_bucket_suffix" {
  byte_length                 = 4
}

resource "google_storage_bucket" "vcd-bucket" {
  name                        = "vcd-bucket-${random_id.vcd_bucket_suffix.hex}"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
  storage_class               = "STANDARD"
}

resource "google_storage_bucket_object" "vcd_binary" {
  name                        = var.vcd_binary_filename
  source                      = "files/vcd-binaries/${var.vcd_binary_filename}"
  bucket                      = google_storage_bucket.vcd-bucket.name
}

resource "google_storage_bucket_object" "vcd_cert_file" {
  name                        = var.vcd_cert_file
  source                      = "files/vcd-cert-file/${var.vcd_cert_file}"
  bucket                      = google_storage_bucket.vcd-bucket.name
}

resource "google_storage_bucket_object" "vcd_cert_private_key_file" {
  name                        = var.vcd_cert_private_key_file
  source                      = "files/vcd-cert-file/${var.vcd_cert_private_key_file}"
  bucket                      = google_storage_bucket.vcd-bucket.name
}
