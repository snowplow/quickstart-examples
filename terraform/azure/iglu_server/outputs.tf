output "iglu_server_lb_ip_address" {
  description = "The load balancers IP address for the Iglu Server"
  value       = module.iglu_lb.ip_address
}

output "iglu_server_lb_fqdn" {
  description = "The load balancers fully-qualified-domain-name for the Iglu Server"
  value       = module.iglu_lb.ip_address_fqdn
}
