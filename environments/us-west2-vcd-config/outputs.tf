output sys_admin_password {
  value       = random_password.sys_admin_pass.result
  description = "Sys Admin Password."
  sensitive = true
}

output org_admin_password {
  value       = module.vcd_org.deafult_org_admin_password
  description = "Default Org Admin Password."
  sensitive = true
}
