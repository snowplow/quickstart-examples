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

provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Deploy PubSub Topics
module "raw_topic" {
  source  = "snowplow-devops/pubsub-topic/google"
  version = "0.1.0"

  name = "${var.prefix}-raw-topic"

  labels = var.labels
}

module "bad_1_topic" {
  source  = "snowplow-devops/pubsub-topic/google"
  version = "0.1.0"

  name = "${var.prefix}-bad-1-topic"

  labels = var.labels
}

module "enriched_topic" {
  source  = "snowplow-devops/pubsub-topic/google"
  version = "0.1.0"

  name = "${var.prefix}-enriched-topic"

  labels = var.labels
}

# 2. Deploy Collector stack
module "collector_pubsub" {
  source  = "snowplow-devops/collector-pubsub-ce/google"
  version = "0.2.2"

  name = "${var.prefix}-collector-server"

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region

  ssh_ip_allowlist = var.ssh_ip_allowlist
  ssh_key_pairs    = var.ssh_key_pairs

  topic_project_id = var.project_id
  good_topic_name  = module.raw_topic.name
  bad_topic_name   = module.bad_1_topic.name

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  labels = var.labels
}

module "collector_lb" {
  source  = "snowplow-devops/lb/google"
  version = "0.1.0"

  name = "${var.prefix}-collector-lb"

  instance_group_named_port_http = module.collector_pubsub.named_port_http
  instance_group_url             = module.collector_pubsub.instance_group_url
  health_check_self_link         = module.collector_pubsub.health_check_self_link

  ssl_certificate_enabled = var.ssl_information.enabled
  ssl_certificate_id      = var.ssl_information.certificate_id
}

# 3. Deploy Enrichment
module "enrich_pubsub" {
  source  = "snowplow-devops/enrich-pubsub-ce/google"
  version = "0.1.1"

  name = "${var.prefix}-enrich-server"

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region

  ssh_ip_allowlist = var.ssh_ip_allowlist
  ssh_key_pairs    = var.ssh_key_pairs

  raw_topic_name = module.raw_topic.name
  good_topic_id  = module.enriched_topic.id
  bad_topic_id   = module.bad_1_topic.id

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  labels = var.labels
}

# 4. Deploy Postgres Loader
module "pipeline_db" {
  source  = "snowplow-devops/cloud-sql/google"
  version = "0.1.0"

  name = "${var.prefix}-pipeline-db"

  region      = var.region
  db_name     = var.pipeline_db_name
  db_username = var.pipeline_db_username
  db_password = var.pipeline_db_password

  authorized_networks = var.pipeline_db_authorized_networks

  tier = var.pipeline_db_tier

  labels = var.labels
}

module "postgres_loader_enriched" {
  source  = "snowplow-devops/postgres-loader-pubsub-ce/google"
  version = "0.2.1"

  name = "${var.prefix}-pg-loader-enriched-server"

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region
  project_id = var.project_id

  ssh_ip_allowlist = var.ssh_ip_allowlist
  ssh_key_pairs    = var.ssh_key_pairs

  in_topic_name = module.enriched_topic.name
  purpose       = "ENRICHED_EVENTS"
  schema_name   = "atomic"

  db_instance_name = module.pipeline_db.connection_name
  db_port          = module.pipeline_db.port
  db_name          = var.pipeline_db_name
  db_username      = var.pipeline_db_username
  db_password      = var.pipeline_db_password

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  labels = var.labels
}

module "postgres_loader_bad" {
  source  = "snowplow-devops/postgres-loader-pubsub-ce/google"
  version = "0.2.1"

  name = "${var.prefix}-pg-loader-bad-server"

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region
  project_id = var.project_id

  ssh_ip_allowlist = var.ssh_ip_allowlist
  ssh_key_pairs    = var.ssh_key_pairs

  in_topic_name = module.bad_1_topic.name
  purpose       = "JSON"
  schema_name   = "atomic_bad"

  db_instance_name = module.pipeline_db.connection_name
  db_port          = module.pipeline_db.port
  db_name          = var.pipeline_db_name
  db_username      = var.pipeline_db_username
  db_password      = var.pipeline_db_password

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  labels = var.labels
}
