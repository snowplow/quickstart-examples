module "bq_bad_rows_topic" {
  source  = "snowplow-devops/pubsub-topic/google"
  version = "0.3.0"

  count = var.bigquery_db_enabled ? 1 : 0

  name = "${var.prefix}-bq-bad-rows-topic"

  labels = var.labels
}

resource "google_bigquery_dataset" "bigquery_db" {
  count = var.bigquery_db_enabled ? 1 : 0

  dataset_id = replace("${var.prefix}_snowplow_db", "-", "_")
  location   = var.region

  labels = var.labels
}

module "bigquery_loader" {
  source  = "snowplow-devops/bigquery-loader-pubsub-ce/google"
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.bigquery_db_enabled ? 1 : 0

  name = "${var.prefix}-bq-loader"

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region
  project_id = var.project_id

  ssh_ip_allowlist = var.ssh_ip_allowlist
  ssh_key_pairs    = var.ssh_key_pairs

  input_topic_name    = module.enriched_topic.name
  bad_rows_topic_id   = join("", module.bq_bad_rows_topic.*.id)
  bigquery_dataset_id = join("", google_bigquery_dataset.bigquery_db.*.dataset_id)

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  associate_public_ip_address = false

  labels = var.labels
}
