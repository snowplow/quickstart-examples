output "iglu_server_dns_name" {
  description = "The ALB dns name for the Iglu Server"
  value       = module.iglu_lb.dns_name
}
