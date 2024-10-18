resource "random_id" "db_name_suffix" {
  byte_length           = 4
}

resource "google_sql_database_instance" "vcddb-instance" {
  name                  = "vcddb-instance-${random_id.db_name_suffix.hex}"
  database_version      = var.pgdb_version 
  region                = var.region
  deletion_protection   = var.sql_deletion_protection
  settings {
    tier                = var.pgdb_tier
    availability_type   = var.pgdb_availability_type
    disk_autoresize     = true
    disk_size           = 20
    disk_type           = "PD_SSD"
    ip_configuration {
      ipv4_enabled      = false
      private_network   = var.network
    }
    dynamic "database_flags" {
      for_each          = var.database_flags
      content {
        name            = database_flags.value.name
        value           = database_flags.value.value
      }
    }
    backup_configuration {
      enabled           = true
      point_in_time_recovery_enabled = true
      start_time        = "07:00"
    }
    maintenance_window {
      day               = 6
      hour              = 05
      update_track      = "stable"
    }
  }
}

resource "random_password" "vcd-user-pass" {
  length                = 16
  special               = true
  override_special      = "/@£$"
}

resource "google_sql_user" "vcd-user" {
  name                  = "vcdsa"
  instance              = google_sql_database_instance.vcddb-instance.name
  password              = random_password.vcd-user-pass.result
}

resource "google_sql_database" "vcddb" {
  name                  = "vcddb"
  instance              = google_sql_database_instance.vcddb-instance.name
  charset               = "UTF8"
  collation             = "en_US.UTF8"
  depends_on            = [ google_sql_user.vcd-user ]
}
