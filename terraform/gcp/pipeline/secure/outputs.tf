output "collector_ip_address" {
  description = "The IP address for the Pipeline Collector"
  value       = module.collector_lb.ip_address
}

output "db_ip_address" {
  description = "The IP address of the database where your data is being streamed"
  value       = module.pipeline_db.first_ip_address
}

output "db_port" {
  description = "The port of the database where your data is being streamed"
  value       = module.pipeline_db.port
}
