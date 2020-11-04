variable "region" {
  description = "GCloud region to use for this deployment."
}

variable "network" {
  description = "The network ID to which to connect teh SQL instance."
}

variable "sql_deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance."
  type        = bool
  default     = true
}

variable "database_flags" {
  description = "List of Cloud SQL flags that are applied to the database server"
  type        = list(any)
  default     = [
      {
        name  = "max_connections"
        value = 500
      },
      {
        name  = "autovacuum"
        value = "on"
      },
      {
        name  = "track_counts"
        value = "on"
      },
      {
        name  = "autovacuum_max_workers"
        value = 3
      },
      {
        name  = "autovacuum_naptime"
        value = 1
      },
      {
        name  = "autovacuum_vacuum_cost_limit"
        value = 2400
      },
  ]
}