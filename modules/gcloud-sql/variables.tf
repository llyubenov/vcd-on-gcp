variable "region" {
  description = "GCloud region to use for this deployment."
}

variable "network" {
  description = "The network ID to which to connect teh SQL instance."
}

variable "pgdb_version" {
  type        = string
  default     = "POSTGRES_15"
  description = "Postgres DB Version."
}

variable "pgdb_tier" {
  type        = string
  default     = "db-custom-4-16384"
  description = "Machine type (tier) for Cloud SQL, for example, db-custom-1-3840."
}

variable "pgdb_availability_type" {
  type        = string
  default     = "REGIONAL"
  description = "The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL)."
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
