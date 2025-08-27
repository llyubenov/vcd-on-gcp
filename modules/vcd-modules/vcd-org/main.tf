resource "vcd_org" "org" {
  name             = var.org_name
  full_name        = var.org_name
  description      = var.org_description
  is_enabled       = true
  delete_recursive = true
  delete_force     = true

  can_publish_external_catalogs   = var.publish_external_catalogs
  can_subscribe_external_catalogs = var.subscribe_external_catalogs

  vapp_lease {
    maximum_runtime_lease_in_sec          = 0 
    power_off_on_runtime_lease_expiration = false
    maximum_storage_lease_in_sec          = 0 # never expires
    delete_on_storage_lease_expiration    = false
  }
  vapp_template_lease {
    maximum_storage_lease_in_sec       = 0
    delete_on_storage_lease_expiration = false
  }
  account_lockout {
    enabled                       = true
    invalid_logins_before_lockout = 3
    lockout_interval_minutes      = 10
  }
}

resource "random_password" "org_admin_pass" {
  length                = 16
  special               = true
  override_special      = "/@£$"
}


resource "vcd_org_user" "org_admin" {
  org = var.org_name

  name        = var.org_admin
  description = "${var.org_name} Default Org Admin."
  role        = "Organization Administrator"
  password    = random_password.org_admin_pass.result
}
