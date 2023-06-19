output "collector_dns_name" {
  description = "The ALB DNS name for the Pipeline Collector"
  value       = module.collector_lb.dns_name
}

# --- Target: PostgreSQL

output "postgres_db_address" {
  description = "The RDS DNS name where your data is being streamed"
  value       = var.postgres_db_enabled ? module.postgres_loader_rds[0].address : null
}

output "postgres_db_port" {
  description = "The RDS port where your data is being streamed"
  value       = var.postgres_db_enabled ? module.postgres_loader_rds[0].port : null
}

output "postgres_db_id" {
  description = "The ID of the RDS instance"
  value       = var.postgres_db_enabled ? module.postgres_loader_rds[0].id : null
}
