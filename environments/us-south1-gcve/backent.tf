terraform {
    backend "gcs" {
        bucket = "dvcf01-hol-gcve-terraform-state"  # Replace with your bucket name
        prefix = "us-central1-gcve/terraform.tfstate"      # Optional: prefix for the state file
        credentials = "../../credentials/dvcf01-hol-gcve-b3748fb3c9ec.json"
    }
}
