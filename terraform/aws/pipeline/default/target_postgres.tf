module "postgres_loader_rds" {
  source  = "snowplow-devops/rds/aws"
  version = "0.4.0"

  count = var.postgres_db_enabled ? 1 : 0

  name        = "${var.prefix}-pipeline-rds"
  vpc_id      = var.vpc_id
  subnet_ids  = var.public_subnet_ids
  db_name     = var.postgres_db_name
  db_username = var.postgres_db_username
  db_password = var.postgres_db_password

  publicly_accessible     = var.postgres_db_publicly_accessible
  additional_ip_allowlist = var.postgres_db_ip_allowlist

  tags = var.tags
}

module "postgres_loader_enriched" {
  source  = "snowplow-devops/postgres-loader-kinesis-ec2/aws"
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.postgres_db_enabled ? 1 : 0

  name       = "${var.prefix}-postgres-loader-enriched-server"
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids

  in_stream_name = module.enriched_stream.name
  purpose        = "ENRICHED_EVENTS"
  schema_name    = "atomic"

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  iam_permissions_boundary = var.iam_permissions_boundary

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  db_sg_id    = module.postgres_loader_rds[0].sg_id
  db_host     = module.postgres_loader_rds[0].address
  db_port     = module.postgres_loader_rds[0].port
  db_name     = var.postgres_db_name
  db_username = var.postgres_db_username
  db_password = var.postgres_db_password

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}

module "postgres_loader_bad" {
  source  = "snowplow-devops/postgres-loader-kinesis-ec2/aws"
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.postgres_db_enabled ? 1 : 0

  name       = "${var.prefix}-postgres-loader-bad-server"
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids

  in_stream_name = module.bad_1_stream.name
  purpose        = "JSON"
  schema_name    = "atomic_bad"

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  iam_permissions_boundary = var.iam_permissions_boundary

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  db_sg_id    = module.postgres_loader_rds[0].sg_id
  db_host     = module.postgres_loader_rds[0].address
  db_port     = module.postgres_loader_rds[0].port
  db_name     = var.postgres_db_name
  db_username = var.postgres_db_username
  db_password = var.postgres_db_password

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}
