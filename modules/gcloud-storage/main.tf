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

resource "google_storage_bucket_object" "vcd-binary" {
  name                        = var.vcd_binary_filename
  source                      = "files/vcd-binaries/${var.vcd_binary_filename}"
  bucket                      = google_storage_bucket.vcd-bucket.name
}

resource "google_storage_bucket_object" "vcd-keystore-file" {
  name                        = var.vcd_keystore_filename
  source                      = "files/vcd-keystore-file/${var.vcd_keystore_filename}"
  bucket                      = google_storage_bucket.vcd-bucket.name
}
