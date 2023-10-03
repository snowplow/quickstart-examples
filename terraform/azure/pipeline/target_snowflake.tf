module "sf_message_queue_eh_topic" {
  source  = "snowplow-devops/event-hub/azurerm"
  version = "0.1.1"

  count = local.use_azure_event_hubs && var.snowflake_enabled ? 1 : 0

  name                = "snowflake-loader-topic"
  namespace_name      = join("", module.eh_namespace.*.name)
  resource_group_name = var.resource_group_name
}

locals {
  snowflake_loader_topic_name = local.use_azure_event_hubs ? join("", module.sf_message_queue_eh_topic.*.name) : var.confluent_cloud_snowflake_loader_topic_name
}

module "sf_transformer_storage_container" {
  source  = "snowplow-devops/storage-container/azurerm"
  version = "0.1.1"

  count = var.snowflake_enabled ? 1 : 0

  name                 = "snowflake-transformer-container"
  storage_account_name = local.storage_account_name
}

module "sf_transformer_wrj" {
  source  = "snowplow-devops/transformer-event-hub-vmss/azurerm"
  version = "0.2.1"

  count = var.snowflake_enabled ? 1 : 0

  name                = "${var.prefix}-snowflake-transformer"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  enriched_topic_name           = local.enriched_topic_name
  enriched_topic_kafka_username = local.kafka_username
  enriched_topic_kafka_password = local.use_azure_event_hubs ? join("", module.enriched_eh_topic.*.read_only_primary_connection_string) : var.confluent_cloud_api_secret
  queue_topic_name              = local.snowflake_loader_topic_name
  queue_topic_kafka_username    = local.kafka_username
  queue_topic_kafka_password    = local.use_azure_event_hubs ? join("", module.sf_message_queue_eh_topic.*.read_write_primary_connection_string) : var.confluent_cloud_api_secret
  eh_namespace_name             = local.eh_namespace_name
  kafka_brokers                 = local.kafka_brokers

  kafka_source = var.stream_type

  storage_account_name   = local.storage_account_name
  storage_container_name = module.sf_transformer_storage_container[0].name
  window_period_min      = var.snowflake_transformer_window_period_min

  widerow_file_format = "json"

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  custom_iglu_resolvers = local.custom_iglu_resolvers

  tags = var.tags

  depends_on = [module.sf_transformer_storage_container]
}

module "sf_loader" {
  source  = "snowplow-devops/snowflake-loader-vmss/azurerm"
  version = "0.2.1"

  count = var.snowflake_enabled ? 1 : 0

  name                = "${var.prefix}-snowflake-loader"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  queue_topic_name           = local.snowflake_loader_topic_name
  queue_topic_kafka_username = local.kafka_username
  queue_topic_kafka_password = local.use_azure_event_hubs ? join("", module.sf_message_queue_eh_topic.*.read_only_primary_connection_string) : var.confluent_cloud_api_secret
  eh_namespace_name          = local.eh_namespace_name
  kafka_brokers              = local.kafka_brokers

  kafka_source = var.stream_type

  storage_account_name                          = local.storage_account_name
  storage_container_name_for_transformer_output = module.sf_transformer_storage_container[0].name

  snowflake_loader_user = var.snowflake_loader_user
  snowflake_password    = var.snowflake_loader_password
  snowflake_warehouse   = var.snowflake_warehouse
  snowflake_database    = var.snowflake_database
  snowflake_schema      = var.snowflake_schema
  snowflake_region      = var.snowflake_region
  snowflake_account     = var.snowflake_account

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  custom_iglu_resolvers = local.custom_iglu_resolvers

  tags = var.tags

  depends_on = [module.sf_transformer_storage_container]
}
