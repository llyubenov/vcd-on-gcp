output vcddb-username {
  value       = google_sql_user.vcd-user.name
  description = "VCD DB User"
}

output vcddb-username-password {
  value       = random_password.vcd-user-pass.result
  description = "VCD DB User Password"
}

output vcddb-name {
  value       = google_sql_database.vcddb.name
  description = "VCD DB NAme"
}

output vcddb-private-ip-address {
  value       = google_sql_database_instance.vcddb-instance.private_ip_address
  description = "VCD DB Private IP to conenct to."
}