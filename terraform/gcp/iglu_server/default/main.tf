provider "google" {
  project = var.project_id
  region  = var.region
}

module "iglu_db" {
  source  = "snowplow-devops/cloud-sql/google"
  version = "0.1.1"

  name = "${var.prefix}-iglu-db"

  region      = var.region
  db_name     = var.iglu_db_name
  db_username = var.iglu_db_username
  db_password = var.iglu_db_password

  labels = var.labels
}

module "iglu_server" {
  source  = "snowplow-devops/iglu-server-ce/google"
  version = "0.3.2"

  name = "${var.prefix}-iglu-server"

  project_id = var.project_id

  network    = var.network
  subnetwork = var.subnetwork
  region     = var.region

  ssh_ip_allowlist = var.ssh_ip_allowlist
  ssh_key_pairs    = var.ssh_key_pairs

  db_instance_name = module.iglu_db.connection_name
  db_port          = module.iglu_db.port
  db_name          = var.iglu_db_name
  db_username      = var.iglu_db_username
  db_password      = var.iglu_db_password
  super_api_key    = var.iglu_super_api_key

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  labels = var.labels
}

module "iglu_lb" {
  source  = "snowplow-devops/lb/google"
  version = "0.1.0"

  name = "${var.prefix}-iglu-lb"

  instance_group_named_port_http = module.iglu_server.named_port_http
  instance_group_url             = module.iglu_server.instance_group_url
  health_check_self_link         = module.iglu_server.health_check_self_link

  ssl_certificate_enabled = var.ssl_information.enabled
  ssl_certificate_id      = var.ssl_information.certificate_id
}
