module "storage_account" {
  # source  = "snowplow-devops/storage-account/azurerm"
  # version = "0.1.1"

  source = "git::https://github.com/snowplow-devops/terraform-azurerm-storage-account.git?ref=release/0.1.1"

  count = var.storage_account_deploy ? 1 : 0

  name                = var.storage_account_name
  resource_group_name = var.resource_group_name

  tags = var.tags
}

locals {
  storage_account_name = var.storage_account_deploy ? join("", module.storage_account.*.name) : var.storage_account_name
}

# 1. Deploy EventHubs topics
module "eh_namespace" {
  source  = "snowplow-devops/event-hub-namespace/azurerm"
  version = "0.1.0"

  name                = "${var.prefix}-namespace"
  resource_group_name = var.resource_group_name

  tags = var.tags
}

module "raw_eh_topic" {
  source  = "snowplow-devops/event-hub/azurerm"
  version = "0.1.0"

  name                = "raw-topic"
  namespace_name      = module.eh_namespace.name
  resource_group_name = var.resource_group_name
}

module "bad_1_eh_topic" {
  source  = "snowplow-devops/event-hub/azurerm"
  version = "0.1.0"

  name                = "bad-1-topic"
  namespace_name      = module.eh_namespace.name
  resource_group_name = var.resource_group_name
}

module "enriched_eh_topic" {
  source  = "snowplow-devops/event-hub/azurerm"
  version = "0.1.0"

  name                = "enriched-topic"
  namespace_name      = module.eh_namespace.name
  resource_group_name = var.resource_group_name
}

# 2. Deploy Collector stack
module "collector_lb" {
  source  = "snowplow-devops/lb/azurerm"
  version = "0.1.0"

  name                = "${var.prefix}-collector-lb"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_lb

  probe_path = "/health"

  ssl_certificate_enabled  = var.ssl_information.enabled
  ssl_certificate_data     = var.ssl_information.data
  ssl_certificate_password = var.ssl_information.password

  tags = var.tags
}

module "collector_eh" {
  source  = "snowplow-devops/collector-event-hub-vmss/azurerm"
  version = "0.1.0"

  name                = "${var.prefix}-collector"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  application_gateway_backend_address_pool_ids = [module.collector_lb.agw_backend_address_pool_id]

  ingress_port = module.collector_lb.agw_backend_egress_port

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  good_topic_name                           = module.raw_eh_topic.name
  bad_topic_name                            = module.bad_1_eh_topic.name
  eh_namespace_broker                       = module.eh_namespace.broker
  eh_namespace_read_write_connection_string = module.eh_namespace.read_write_primary_connection_string

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  tags = var.tags
}

# 3. Deploy Enrich stack
module "enrich_eh" {
  source  = "snowplow-devops/enrich-event-hub-vmss/azurerm"
  version = "0.1.1"

  name                = "${var.prefix}-enrich"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  raw_topic_name               = module.raw_eh_topic.name
  raw_topic_connection_string  = module.raw_eh_topic.read_only_primary_connection_string
  good_topic_name              = module.enriched_eh_topic.name
  good_topic_connection_string = module.enriched_eh_topic.read_write_primary_connection_string
  bad_topic_name               = module.bad_1_eh_topic.name
  bad_topic_connection_string  = module.bad_1_eh_topic.read_write_primary_connection_string
  eh_namespace_name            = module.eh_namespace.name
  eh_namespace_broker          = module.eh_namespace.broker

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  tags = var.tags
}
