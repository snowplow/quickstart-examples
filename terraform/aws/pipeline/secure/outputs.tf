output "collector_dns_name" {
  description = "The ALB dns name for the Pipeline Collector"
  value       = module.collector_lb.dns_name
}

output "postgres_db_address" {
  description = "The RDS dns name where your data is being streamed"
  value       = local.postgres_enabled ? module.pipeline_rds[0].address : null
}

output "postgres_db_port" {
  description = "The RDS port where your data is being streamed"
  value       = local.postgres_enabled ? module.pipeline_rds[0].port : null
}

output "postgres_db_id" {
  description = "The ID of the RDS instance"
  value       = local.postgres_enabled ? module.pipeline_rds[0].id : null
}
