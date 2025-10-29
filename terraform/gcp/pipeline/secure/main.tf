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
  version = "0.3.0"

  name = "${var.prefix}-raw-topic"

  labels = var.labels
}

module "bad_1_topic" {
  source  = "snowplow-devops/pubsub-topic/google"
  version = "0.3.0"

  name = "${var.prefix}-bad-1-topic"

  labels = var.labels
}

module "enriched_topic" {
  source  = "snowplow-devops/pubsub-topic/google"
  version = "0.3.0"

  name = "${var.prefix}-enriched-topic"

  labels = var.labels
}

# 2. Deploy Collector stack
module "collector_pubsub" {
  source  = "snowplow-devops/collector-pubsub-ce/google"
  version = "0.7.0"

  accept_limited_use_license = var.accept_limited_use_license

  name = "${var.prefix}-collector"

  project_id = var.project_id

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

  associate_public_ip_address = false

  labels = var.labels
}

module "collector_lb" {
  source  = "snowplow-devops/lb/google"
  version = "0.3.0"

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
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  name = "${var.prefix}-enrich"

  project_id = var.project_id

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

  associate_public_ip_address = false

  labels = var.labels
}
