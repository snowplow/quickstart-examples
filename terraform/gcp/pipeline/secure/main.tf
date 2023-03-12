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

  bigquery_enabled = (
    var.pipeline_db == "bigquery"
    && var.bigquery_loader_dead_letter_bucket_deploy != ""
    && var.bigquery_loader_dead_letter_bucket_name != ""
  )

  snowflake_enabled = (
    var.pipeline_db == "snowflake"
    && var.snowflake_account != ""
    && var.snowflake_region != ""
    && var.snowflake_loader_user != ""
    && var.snowflake_loader_password != ""
    && var.snowflake_database != ""
    && var.snowflake_schema != ""
    && var.snowflake_loader_role != ""
    && var.snowflake_warehouse != ""
    && var.snowflake_transformed_stage_name != ""
  )

  databricks_enabled = (
    var.pipeline_db == "databricks"
    && var.deltalake_catalog != ""
    && var.deltalake_schema != ""
    && var.deltalake_host != ""
    && var.deltalake_port != ""
    && var.deltalake_http_path != ""
    && var.deltalake_auth_token != ""
  )

  postgres_enabled = (
    var.pipeline_db == "postgres"
    && var.postgres_db_name != ""
    && var.postgres_db_username != ""
    && var.postgres_db_password != ""
  )
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

module "transformed_topic" {
  source  = "snowplow-devops/pubsub-topic/google"
  version = "0.1.0"

  name = "${var.prefix}-transformed-topic"

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

  associate_public_ip_address = false

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
  version = "0.1.2"

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

  associate_public_ip_address = false

  labels = var.labels
}

# 4. Deploy Postgres Loader
module "postgres_db" {
  source  = "snowplow-devops/cloud-sql/google"
  version = "0.1.1"

  count = local.postgres_enabled ? 1 : 0

  name = "${var.prefix}-postgres-db"

  region      = var.region
  db_name     = var.postgres_db_name
  db_username = var.postgres_db_username
  db_password = var.postgres_db_password

  authorized_networks = var.postgres_db_authorized_networks

  tier = var.postgres_db_tier

  labels = var.labels
}

module "postgres_loader_enriched" {
  source  = "snowplow-devops/postgres-loader-pubsub-ce/google"
  version = "0.2.1"

  count = local.postgres_enabled ? 1 : 0

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

  db_instance_name = join("", module.postgres_db.*.connection_name)
  db_port          = join("", module.postgres_db.*.port)
  db_name          = var.postgres_db_name
  db_username      = var.postgres_db_username
  db_password      = var.postgres_db_password

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  labels = var.labels
}

module "postgres_loader_bad" {
  source  = "snowplow-devops/postgres-loader-pubsub-ce/google"
  version = "0.2.1"

  count = local.postgres_enabled ? 1 : 0

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

  db_instance_name = join("", module.postgres_db.*.connection_name)
  db_port          = join("", module.postgres_db.*.port)
  db_name          = var.postgres_db_name
  db_username      = var.postgres_db_username
  db_password      = var.postgres_db_password

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  labels = var.labels
}

# 5. Deploy BigQuery Loader
module "bad_rows_topic" {
  source  = "snowplow-devops/pubsub-topic/google"
  version = "0.1.0"

  count = local.bigquery_enabled ? 1 : 0

  name = "${var.prefix}-bq-bad-rows-topic"

  labels = var.labels
}

resource "google_bigquery_dataset" "bigquery_db" {
  count = local.bigquery_enabled ? 1 : 0

  dataset_id = replace("${var.prefix}_snowplow_db", "-", "_")
  location   = var.region

  labels = var.labels
}

resource "google_storage_bucket" "bq_loader_dead_letter_bucket" {
  count = local.bigquery_enabled && var.bigquery_loader_dead_letter_bucket_deploy ? 1 : 0

  name          = var.bigquery_loader_dead_letter_bucket_name
  location      = var.region
  force_destroy = true

  labels = var.labels
}

locals {
  bq_loader_dead_letter_bucket_name = coalesce(
    join("", google_storage_bucket.bq_loader_dead_letter_bucket.*.name),
    var.bigquery_loader_dead_letter_bucket_name,
  )
}

module "bigquery_loader" {
  source  = "snowplow-devops/bigquery-loader-pubsub-ce/google"
  version = "0.1.0"

  count = local.bigquery_enabled ? 1 : 0

  name = "${var.prefix}-bq-loader-server"

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region
  project_id = var.project_id

  ssh_ip_allowlist = var.ssh_ip_allowlist
  ssh_key_pairs    = var.ssh_key_pairs

  input_topic_name            = module.enriched_topic.name
  bad_rows_topic_name         = join("", module.bad_rows_topic.*.name)
  gcs_dead_letter_bucket_name = local.bq_loader_dead_letter_bucket_name
  bigquery_dataset_id         = join("", google_bigquery_dataset.bigquery_db.*.dataset_id)

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  labels = var.labels
}

# 6. Deploy Transformer and Snowflake/Databricks loader
resource "google_storage_bucket" "transformer_bucket" {
  count = (local.snowflake_enabled || local.databricks_enabled) ? 1 : 0

  name          = "${var.prefix}-${var.transformer_bucket_name}"
  location      = var.region
  force_destroy = true

  labels = var.labels
}

module "transformer_pubsub_enriched" {
  # source  = "snowplow-devops/transformer-pubsub-ce/google"
  # version = "0.1.0"
  source = "../../../../../terraform-google-transformer-pubsub-ce"

  count = (local.snowflake_enabled || local.databricks_enabled) ? 1 : 0

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region
  project_id = var.project_id

  input_topic_name         = module.enriched_topic.name
  message_queue_topic_name = module.transformed_topic.name

  name                  = "${var.prefix}-transformer"
  ssh_key_pairs         = var.ssh_key_pairs
  ssh_ip_allowlist      = var.ssh_ip_allowlist
  transformation_type   = "widerow"
  widerow_file_format   = local.snowflake_enabled ? "json" : "parquet"
  custom_iglu_resolvers = local.custom_iglu_resolvers
  telemetry_enabled     = var.telemetry_enabled
  user_provided_id      = var.user_provided_id
  transformer_output    = google_storage_bucket.transformer_bucket[0].name

  labels = var.labels
}

module "snowflake_loader" {
  # source = "snowplow-devops/snowflake-loader-google-ce/gcp"
  # version = "0.1.0"
  source = "../../../../../terraform-google-snowflake-loader-pubsub-ce"

  count = local.snowflake_enabled ? 1 : 0

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region
  project_id = var.project_id

  name                                  = "${var.prefix}-snowflake"
  ssh_key_pairs                         = var.ssh_key_pairs
  input_topic_name                      = module.transformed_topic.name
  ssh_ip_allowlist                      = var.ssh_ip_allowlist
  snowflake_region                      = var.snowflake_region
  snowflake_account                     = var.snowflake_account
  snowflake_loader_user                 = var.snowflake_loader_user
  snowflake_password                    = var.snowflake_loader_password
  snowflake_database                    = var.snowflake_database
  snowflake_schema                      = var.snowflake_schema
  snowflake_loader_role                 = var.snowflake_loader_role
  snowflake_warehouse                   = var.snowflake_warehouse
  snowflake_transformed_stage_name      = var.snowflake_transformed_stage_name
  snowflake_folder_monitoring_stage_url = ""
  snowflake_callback_iam                = var.snowflake_callback_iam
  telemetry_enabled                     = var.telemetry_enabled
  user_provided_id                      = var.user_provided_id
  custom_iglu_resolvers                 = local.custom_iglu_resolvers

  transformer_output = google_storage_bucket.transformer_bucket[0].name

  labels = var.labels
}

module "databricks_loader" {
  # source = "snowplow-devops/snowflake-loader-google-ce/gcp"
  # version = "0.1.0"
  source = "../../../../../terraform-google-databricks-loader-pubsub-ce"

  count = local.databricks_enabled ? 1 : 0

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region
  project_id = var.project_id

  name                                   = "${var.prefix}-databricks"
  ssh_key_pairs                          = var.ssh_key_pairs
  input_topic_name                       = module.transformed_topic.name
  ssh_ip_allowlist                       = var.ssh_ip_allowlist
  deltalake_catalog                      = var.deltalake_catalog
  deltalake_schema                       = var.deltalake_schema
  deltalake_host                         = var.deltalake_host
  deltalake_port                         = var.deltalake_port
  deltalake_http_path                    = var.deltalake_http_path
  deltalake_auth_token                   = var.deltalake_auth_token
  databricks_callback_iam                = var.databricks_callback_iam
  databricks_folder_monitoring_stage_url = ""
  telemetry_enabled                      = var.telemetry_enabled
  user_provided_id                       = var.user_provided_id
  custom_iglu_resolvers                  = local.custom_iglu_resolvers

  transformer_output = google_storage_bucket.transformer_bucket[0].name

  labels = var.labels
}
