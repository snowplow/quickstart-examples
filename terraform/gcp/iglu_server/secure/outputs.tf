output "iglu_server_ip_address" {
  description = "The IP address for the Iglu Server"
  value       = module.iglu_lb.ip_address
}
