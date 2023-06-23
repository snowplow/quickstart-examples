output "collector_lb_ip_address" {
  description = "The load balancers IP address for the Collector"
  value       = module.collector_lb.ip_address
}

output "collector_lb_fqdn" {
  description = "The load balancers fully-qualified-domain-name for the Collector"
  value       = module.collector_lb.ip_address_fqdn
}
