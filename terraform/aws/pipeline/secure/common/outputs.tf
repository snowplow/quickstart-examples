output "collector_dns_name" {
  value = module.collector_lb.dns_name
}

output "ssh_key_name" {
  value = aws_key_pair.pipeline.key_name
}

output "custom_iglu_resolvers" {
  value = local.custom_iglu_resolvers
}

output "enriched_stream_name" {
  value = module.enriched_stream.name
}

output "bad_stream_name" {
  value = module.bad_1_stream.name
}
