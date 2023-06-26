module "db_message_queue_eh_topic" {
  source  = "snowplow-devops/event-hub/azurerm"
  version = "0.1.0"

  count = var.databricks_enabled ? 1 : 0

  name                = "databricks-loader-topic"
  namespace_name      = module.eh_namespace.name
  resource_group_name = var.resource_group_name
}

module "db_transformer_storage_container" {
  source  = "snowplow-devops/storage-container/azurerm"
  version = "0.1.0"

  count = var.databricks_enabled ? 1 : 0

  name                 = "databricks-transformer-container"
  storage_account_name = local.storage_account_name
}

module "db_transformer_wrp" {
  # source  = "snowplow-devops/transformer-event-hub-vmss/azurerm"
  # version = "0.1.0"

  source = "/Users/jbeemster/Documents/Github/terraform-azurerm-transformer-event-hub-vmss"

  count = var.databricks_enabled ? 1 : 0

  name                = "${var.prefix}-databricks-transformer"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  enriched_topic_name              = module.enriched_eh_topic.name
  enriched_topic_connection_string = module.enriched_eh_topic.read_only_primary_connection_string
  queue_topic_name                 = module.db_message_queue_eh_topic[0].name
  queue_topic_connection_string    = module.db_message_queue_eh_topic[0].read_write_primary_connection_string
  eh_namespace_name                = module.eh_namespace.name
  eh_namespace_broker              = module.eh_namespace.broker

  storage_account_name   = local.storage_account_name
  storage_container_name = module.db_transformer_storage_container[0].name
  window_period_min      = var.databricks_transformer_window_period_min

  widerow_file_format = "parquet"

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  tags = var.tags

  depends_on = [module.db_transformer_storage_container]
}
