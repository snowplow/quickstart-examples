resource "aws_sqs_queue" "db_message_queue" {
  count = var.databricks_enabled ? 1 : 0

  content_based_deduplication = true
  name                        = "${var.prefix}-db-loader.fifo"
  fifo_queue                  = true
  kms_master_key_id           = "alias/aws/sqs"
}

module "db_transformer_wrp" {
  source  = "snowplow-devops/transformer-kinesis-ec2/aws"
  version = "0.4.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.databricks_enabled ? 1 : 0

  name       = "${var.prefix}-transformer-server-wrp"
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids

  stream_name             = module.enriched_stream.name
  s3_bucket_name          = local.s3_pipeline_bucket_name
  s3_bucket_object_prefix = "${var.s3_bucket_object_prefix}transformed/good/widerow/parquet"
  window_period_min       = var.databricks_transformer_window_period_min
  sqs_queue_name          = aws_sqs_queue.db_message_queue[0].name

  transformation_type = "widerow"
  widerow_file_format = "parquet"

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  custom_iglu_resolvers = local.custom_iglu_resolvers

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  iam_permissions_boundary = var.iam_permissions_boundary

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}

module "db_loader" {
  source  = "snowplow-devops/databricks-loader-ec2/aws"
  version = "0.2.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.databricks_enabled ? 1 : 0

  name       = "${var.prefix}-db-loader-server"
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids

  sqs_queue_name = aws_sqs_queue.db_message_queue[0].name

  deltalake_catalog             = var.databricks_catalog
  deltalake_schema              = var.databricks_schema
  deltalake_host                = var.databricks_host
  deltalake_port                = var.databricks_port
  deltalake_http_path           = var.databricks_http_path
  deltalake_auth_token          = var.databricks_auth_token
  databricks_aws_s3_bucket_name = local.s3_pipeline_bucket_name

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  custom_iglu_resolvers = local.custom_iglu_resolvers

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  iam_permissions_boundary = var.iam_permissions_boundary

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}
