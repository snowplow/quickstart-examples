locals {
  custom_iglu_resolvers = [
    {
      name            = "Iglu Server"
      priority        = 0
      uri             = "${var.iglu_server_dns_name}/api"
      api_key         = var.iglu_super_api_key
      vendor_prefixes = []
    }
  ]
}

module "storage_account" {
  source  = "snowplow-devops/storage-account/azurerm"
  version = "0.1.3"

  count = var.storage_account_deploy ? 1 : 0

  name                = var.storage_account_name
  resource_group_name = var.resource_group_name

  tags = var.tags
}

locals {
  storage_account_name = var.storage_account_deploy ? join("", module.storage_account.*.name) : var.storage_account_name

  # Note: as the options are only EventHubs or Confluent Cloud we want to default to EventHubs
  #       unless Confluent Cloud is *explictly selected*.
  #
  #       This logic will need to change should we support multiple streaming options.
  use_azure_event_hubs = var.stream_type != "confluent_cloud"
}

# 1. Deploy EventHubs topics
module "eh_namespace" {
  source  = "snowplow-devops/event-hub-namespace/azurerm"
  version = "0.1.1"

  count = local.use_azure_event_hubs ? 1 : 0

  name                = "${var.prefix}-namespace"
  resource_group_name = var.resource_group_name

  tags = var.tags
}

module "raw_eh_topic" {
  source  = "snowplow-devops/event-hub/azurerm"
  version = "0.1.1"

  count = local.use_azure_event_hubs ? 1 : 0

  name                = "raw-topic"
  namespace_name      = join("", module.eh_namespace.*.name)
  resource_group_name = var.resource_group_name
}

module "bad_1_eh_topic" {
  source  = "snowplow-devops/event-hub/azurerm"
  version = "0.1.1"

  count = local.use_azure_event_hubs ? 1 : 0

  name                = "bad-1-topic"
  namespace_name      = join("", module.eh_namespace.*.name)
  resource_group_name = var.resource_group_name
}

module "enriched_eh_topic" {
  source  = "snowplow-devops/event-hub/azurerm"
  version = "0.1.1"

  count = local.use_azure_event_hubs ? 1 : 0

  name                = "enriched-topic"
  namespace_name      = join("", module.eh_namespace.*.name)
  resource_group_name = var.resource_group_name
}

# 2. Figure out which Kafka Cluster to use

locals {
  kafka_brokers  = local.use_azure_event_hubs ? join("", module.eh_namespace.*.broker) : var.confluent_cloud_bootstrap_server
  kafka_username = local.use_azure_event_hubs ? "$ConnectionString" : var.confluent_cloud_api_key

  eh_namespace_name = local.use_azure_event_hubs ? join("", module.eh_namespace.*.name) : ""

  raw_topic_name      = local.use_azure_event_hubs ? join("", module.raw_eh_topic.*.name) : var.confluent_cloud_raw_topic_name
  bad_1_topic_name    = local.use_azure_event_hubs ? join("", module.bad_1_eh_topic.*.name) : var.confluent_cloud_bad_1_topic_name
  enriched_topic_name = local.use_azure_event_hubs ? join("", module.enriched_eh_topic.*.name) : var.confluent_cloud_enriched_topic_name
}

# 3. Deploy Collector stack
module "collector_lb" {
  source  = "snowplow-devops/lb/azurerm"
  version = "0.2.0"

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
  version = "0.4.0"

  accept_limited_use_license = var.accept_limited_use_license

  name                = "${var.prefix}-collector"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  application_gateway_backend_address_pool_ids = [module.collector_lb.agw_backend_address_pool_id]

  ingress_port = module.collector_lb.agw_backend_egress_port

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  good_topic_name           = local.raw_topic_name
  good_topic_kafka_username = local.kafka_username
  good_topic_kafka_password = local.use_azure_event_hubs ? join("", module.raw_eh_topic.*.read_write_primary_connection_string) : var.confluent_cloud_api_secret
  bad_topic_name            = local.bad_1_topic_name
  bad_topic_kafka_username  = local.kafka_username
  bad_topic_kafka_password  = local.use_azure_event_hubs ? join("", module.bad_1_eh_topic.*.read_write_primary_connection_string) : var.confluent_cloud_api_secret
  kafka_brokers             = local.kafka_brokers

  kafka_source = var.stream_type

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  tags = var.tags
}

# 4. Deploy Enrich stack
module "enrich_eh" {
  source  = "snowplow-devops/enrich-event-hub-vmss/azurerm"
  version = "0.4.0"

  accept_limited_use_license = var.accept_limited_use_license

  name                = "${var.prefix}-enrich"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  raw_topic_name            = local.raw_topic_name
  raw_topic_kafka_username  = local.kafka_username
  raw_topic_kafka_password  = local.use_azure_event_hubs ? join("", module.raw_eh_topic.*.read_only_primary_connection_string) : var.confluent_cloud_api_secret
  good_topic_name           = local.enriched_topic_name
  good_topic_kafka_username = local.kafka_username
  good_topic_kafka_password = local.use_azure_event_hubs ? join("", module.enriched_eh_topic.*.read_write_primary_connection_string) : var.confluent_cloud_api_secret
  bad_topic_name            = local.bad_1_topic_name
  bad_topic_kafka_username  = local.kafka_username
  bad_topic_kafka_password  = local.use_azure_event_hubs ? join("", module.bad_1_eh_topic.*.read_write_primary_connection_string) : var.confluent_cloud_api_secret
  eh_namespace_name         = local.eh_namespace_name
  kafka_brokers             = local.kafka_brokers

  kafka_source = var.stream_type

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  custom_iglu_resolvers = local.custom_iglu_resolvers

  tags = var.tags
}
