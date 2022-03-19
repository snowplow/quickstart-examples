output "collector_dns_name" {
  description = "The ALB dns name for the Pipeline Collector"
  value       = module.common.collector_dns_name
}

output "db_address" {
  description = "The RDS dns name where your data is being streamed"
  value       = module.pipeline_rds.address
}

output "db_port" {
  description = "The RDS port where your data is being streamed"
  value       = module.pipeline_rds.port
}

output "db_id" {
  description = "The ID of the RDS instance"
  value       = module.pipeline_rds.id
}
