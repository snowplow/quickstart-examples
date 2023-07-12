module "sf_message_queue_eh_topic" {
  source  = "snowplow-devops/event-hub/azurerm"
  version = "0.1.0"

  count = var.snowflake_enabled ? 1 : 0

  name                = "snowflake-loader-topic"
  namespace_name      = module.eh_namespace.name
  resource_group_name = var.resource_group_name
}

module "sf_transformer_storage_container" {
  source  = "snowplow-devops/storage-container/azurerm"
  version = "0.1.0"

  count = var.snowflake_enabled ? 1 : 0

  name                 = "snowflake-transformer-container"
  storage_account_name = local.storage_account_name
}

module "sf_transformer_staging_container" {
  source  = "snowplow-devops/storage-container/azurerm"
  version = "0.1.0"

  count = var.snowflake_enabled ? 1 : 0

  name                 = "snowflake-staging-container"
  storage_account_name = local.storage_account_name
}

module "sf_transformer_wrj" {
  # source  = "snowplow-devops/transformer-event-hub-vmss/azurerm"
  # version = "0.1.0"

  source = "git::https://github.com/snowplow-devops/terraform-azurerm-transformer-event-hub-vmss.git?ref=release/0.1.0"

  count = var.snowflake_enabled ? 1 : 0

  name                = "${var.prefix}-snowflake-transformer"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  enriched_topic_name              = module.enriched_eh_topic.name
  enriched_topic_connection_string = module.enriched_eh_topic.read_only_primary_connection_string
  queue_topic_name                 = module.sf_message_queue_eh_topic[0].name
  queue_topic_connection_string    = module.sf_message_queue_eh_topic[0].read_write_primary_connection_string
  eh_namespace_name                = module.eh_namespace.name
  eh_namespace_broker              = module.eh_namespace.broker

  storage_account_name   = local.storage_account_name
  storage_container_name = module.sf_transformer_storage_container[0].name
  window_period_min      = var.snowflake_transformer_window_period_min

  widerow_file_format = "json"

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  tags = var.tags

  depends_on = [module.sf_transformer_storage_container]
}

module "sf_loader" {
  # source  = "snowplow-devops/snowflake-loader-vmss/azurerm"
  # version = "0.1.0"

  source = "git::https://github.com/snowplow-devops/terraform-azurerm-snowflake-loader-vmss.git?ref=release/0.1.0"

  count = var.snowflake_enabled ? 1 : 0

  name                = "${var.prefix}-snowflake-loader"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  queue_topic_name              = module.sf_message_queue_eh_topic[0].name
  queue_topic_connection_string = module.sf_message_queue_eh_topic[0].read_only_primary_connection_string
  eh_namespace_name             = module.eh_namespace.name
  eh_namespace_broker           = module.eh_namespace.broker

  storage_account_name                          = local.storage_account_name
  storage_container_name_for_transformer_output = module.sf_transformer_storage_container[0].name
  storage_container_name_for_folder_monitoring_staging = module.sf_transformer_staging_container[0].name 

  snowflake_loader_user = var.snowflake_loader_user
  snowflake_password    = var.snowflake_loader_password
  snowflake_warehouse   = var.snowflake_warehouse
  snowflake_database    = var.snowflake_database
  snowflake_schema      = var.snowflake_schema
  snowflake_region      = var.snowflake_region
  snowflake_account     = var.snowflake_account
  folder_monitoring_enabled = var.snowflake_folder_monitoring_enabled 
  folder_monitoring_period = var.snowflake_folder_monitoring_period 
          
  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  tags = var.tags

  depends_on = [module.sf_transformer_storage_container]
}
