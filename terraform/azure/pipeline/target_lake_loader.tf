module "lake_storage_container" {
  source  = "snowplow-devops/storage-container/azurerm"
  version = "0.1.1"

  count = var.lake_enabled ? 1 : 0

  name                 = "lake-container"
  storage_account_name = local.storage_account_name
}

module "lake_loader" {
  source  = "snowplow-devops/lake-loader-vmss/azurerm"
  version = "0.3.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.lake_enabled ? 1 : 0

  name                = "${var.prefix}-lake-loader"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  enriched_topic_name           = local.enriched_topic_name
  enriched_topic_kafka_username = local.kafka_username
  enriched_topic_kafka_password = local.use_azure_event_hubs ? join("", module.enriched_eh_topic.*.read_only_primary_connection_string) : var.confluent_cloud_api_secret
  bad_topic_name                = local.bad_1_topic_name
  bad_topic_kafka_username      = local.kafka_username
  bad_topic_kafka_password      = local.use_azure_event_hubs ? join("", module.bad_1_eh_topic.*.read_write_primary_connection_string) : var.confluent_cloud_api_secret
  eh_namespace_name             = local.eh_namespace_name
  kafka_brokers                 = local.kafka_brokers

  kafka_source = var.stream_type

  storage_account_name   = local.storage_account_name
  storage_container_name = module.lake_storage_container[0].name

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  custom_iglu_resolvers = local.custom_iglu_resolvers

  tags = var.tags

  depends_on = [module.lake_storage_container]
}
