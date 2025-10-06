locals {
    project = "dvcf01-hol-gcve"
    region  = "us-west2"
    gcve_network_name = "sddc-network-us-west2"
}

remote_state {
  backend      = "gcs"
  #disable_init = true

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    project     = local.project
    location    = "us"
    bucket      = "dvcf01-hol-gcve-terraform-state"
    skip_bucket_creation = true
    prefix      = "/us-west2-tg/${path_relative_to_include()}/state.tfstate"
    credentials = file("${get_terragrunt_dir()}/../../../../credentials/dvcf01-hol-gcve-b3748fb3c9ec.json")
  }
}

inputs = {
  # Define your input variables here
  project = local.project
  region  = local.region
}

generate "provider" {
  path = "google_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "google" {
  credentials         = file("${get_terragrunt_dir()}/../../../../credentials/dvcf01-hol-gcve-b3748fb3c9ec.json")
  project             = "${local.project}"
}
provider "google-beta" {
  credentials         = file("${path_relative_to_include()}/../../../../credentials/dvcf01-hol-gcve-b3748fb3c9ec.json")
  project             = "${local.project}"
}
EOF
}
