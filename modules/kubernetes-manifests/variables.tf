variable "postgres_user" {
  description = "PostgreSQL root user"
  type        = string
  sensitive   = true
}

variable "postgres_password" {
  description = "PostgreSQL root password"
  type        = string
  sensitive   = true
}

variable "postgres_non_root_user" {
  description = "PostgreSQL non-root user for n8n"
  type        = string
  sensitive   = true
}

variable "postgres_non_root_password" {
  description = "PostgreSQL non-root password"
  type        = string
  sensitive   = true
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
  default     = "n8n"
}
