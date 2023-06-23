module "iglu_db" {
  source  = "snowplow-devops/postgresql-server/azurerm"
  version = "0.1.1"

  name                = "${var.prefix}-iglu-db"
  resource_group_name = var.resource_group_name

  subnet_id = var.subnet_id_servers

  additional_ip_allowlist = var.iglu_db_ip_allowlist

  db_name     = var.iglu_db_name
  db_username = var.iglu_db_username
  db_password = var.iglu_db_password

  tags = var.tags
}

module "iglu_lb" {
  source  = "snowplow-devops/lb/azurerm"
  version = "0.1.1"

  name                = "${var.prefix}-iglu-lb"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_lb

  probe_path = "/api/meta/health"

  ssl_certificate_enabled  = var.ssl_information.enabled
  ssl_certificate_data     = var.ssl_information.data
  ssl_certificate_password = var.ssl_information.password

  tags = var.tags
}

module "iglu_server" {
  source  = "snowplow-devops/iglu-server-vmss/azurerm"
  version = "0.1.1"

  name                = "${var.prefix}-iglu-server"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_servers

  application_gateway_backend_address_pool_ids = [module.iglu_lb.agw_backend_address_pool_id]

  ingress_port = module.iglu_lb.agw_backend_egress_port

  ssh_public_key   = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  db_name     = module.iglu_db.db_name
  db_host     = module.iglu_db.db_host
  db_port     = module.iglu_db.db_port
  db_username = module.iglu_db.db_username
  db_password = module.iglu_db.db_password

  super_api_key = var.iglu_super_api_key

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  tags = var.tags
}
