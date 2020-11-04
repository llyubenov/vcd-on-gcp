output bucket-url {
  value       = google_storage_bucket.vcd-bucket.url
  description = "Bucket URL, e.g. - gs://<bucket-name>"
}