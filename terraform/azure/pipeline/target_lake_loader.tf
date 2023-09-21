module "lake_storage_container" {
  source  = "snowplow-devops/storage-container/azurerm"
  version = "0.1.1"

  count = var.lake_enabled ? 1 : 0

  name                 = "lake-container"
  storage_account_name = local.storage_account_name
}

module "lake_loader" {
  source  = "snowplow-devops/lake-loader-vmss/azurerm"
  version = "0.1.1"

  count = var.lake_enabled ? 1 : 0

  name                = "${var.prefix}-lake-loader"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  enriched_topic_name              = module.enriched_eh_topic.name
  enriched_topic_connection_string = module.enriched_eh_topic.read_only_primary_connection_string
  bad_topic_name                   = module.bad_1_eh_topic.name
  bad_topic_connection_string      = module.bad_1_eh_topic.read_write_primary_connection_string
  eh_namespace_name                = module.eh_namespace.name
  eh_namespace_broker              = module.eh_namespace.broker

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
