module "common" {
  source = "../common"

  prefix = var.prefix
  vpc_id = var.vpc_id
  public_subnet_ids  = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids

  s3_bucket_name = var.s3_bucket_name
  s3_bucket_deploy = var.s3_bucket_deploy
  s3_bucket_object_prefix = var.s3_bucket_object_prefix

  ssh_public_key = var.ssh_public_key
  ssh_ip_allowlist = var.ssh_ip_allowlist

  iglu_server_dns_name = var.iglu_server_dns_name
  iglu_super_api_key = var.iglu_super_api_key

  pipeline_kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id
  
  iam_permissions_boundary = var.iam_permissions_boundary
  
  ssl_information = var.ssl_information
  
  tags = var.tags
  
  cloudwatch_logs_enabled = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}

module "pipeline_rds" {
  source  = "snowplow-devops/rds/aws"
  version = "0.1.4"

  name        = "${var.prefix}-pipeline-rds"
  vpc_id      = var.vpc_id
  subnet_ids  = var.private_subnet_ids
  db_name     = var.pg_db_name
  db_username = var.pg_db_username
  db_password = var.pg_db_password

  publicly_accessible     = false
  additional_ip_allowlist = var.pg_db_ip_allowlist

  tags = var.tags
}

module "postgres_loader_enriched" {
  source  = "snowplow-devops/postgres-loader-kinesis-ec2/aws"
  version = "0.2.0"

  name       = "${var.prefix}-postgres-loader-enriched-server"
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  in_stream_name = module.common.enriched_stream_name
  purpose        = "ENRICHED_EVENTS"
  schema_name    = "atomic"

  ssh_key_name     = module.common.ssh_key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  iam_permissions_boundary = var.iam_permissions_boundary

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = module.common.custom_iglu_resolvers

  db_sg_id    = module.pipeline_rds.sg_id
  db_host     = module.pipeline_rds.address
  db_port     = module.pipeline_rds.port
  db_name     = var.pg_db_name
  db_username = var.pg_db_username
  db_password = var.pg_db_password

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  associate_public_ip_address = false

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}

module "postgres_loader_bad" {
  source  = "snowplow-devops/postgres-loader-kinesis-ec2/aws"
  version = "0.2.0"

  name       = "${var.prefix}-postgres-loader-bad-server"
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  in_stream_name = module.common.bad_stream_name
  purpose        = "JSON"
  schema_name    = "atomic_bad"

  ssh_key_name     = module.common.ssh_key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  iam_permissions_boundary = var.iam_permissions_boundary

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = module.common.custom_iglu_resolvers

  db_sg_id    = module.pipeline_rds.sg_id
  db_host     = module.pipeline_rds.address
  db_port     = module.pipeline_rds.port
  db_name     = var.pg_db_name
  db_username = var.pg_db_username
  db_password = var.pg_db_password

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  associate_public_ip_address = false

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}
