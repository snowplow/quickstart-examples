module "postgres_db" {
  source  = "snowplow-devops/cloud-sql/google"
  version = "0.4.1"

  count = var.postgres_db_enabled ? 1 : 0

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
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.postgres_db_enabled ? 1 : 0

  name = "${var.prefix}-pg-loader-enriched"

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

  associate_public_ip_address = false

  labels = var.labels
}

module "postgres_loader_bad" {
  source  = "snowplow-devops/postgres-loader-pubsub-ce/google"
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.postgres_db_enabled ? 1 : 0

  name = "${var.prefix}-pg-loader-bad"

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

  associate_public_ip_address = false

  labels = var.labels
}
