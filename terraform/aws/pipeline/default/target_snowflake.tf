resource "aws_sqs_queue" "sf_message_queue" {
  count = var.snowflake_enabled ? 1 : 0

  content_based_deduplication = true
  name                        = "${var.prefix}-sf-loader.fifo"
  fifo_queue                  = true
  kms_master_key_id           = "alias/aws/sqs"
}

module "sf_transformer_wrj" {
  source  = "snowplow-devops/transformer-kinesis-ec2/aws"
  version = "0.4.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.snowflake_enabled ? 1 : 0

  name       = "${var.prefix}-transformer-server-wrj"
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids

  stream_name             = module.enriched_stream.name
  s3_bucket_name          = local.s3_pipeline_bucket_name
  s3_bucket_object_prefix = "${var.s3_bucket_object_prefix}transformed/good/widerow/json"
  window_period_min       = var.snowflake_transformer_window_period_min
  sqs_queue_name          = aws_sqs_queue.sf_message_queue[0].name

  transformation_type = "widerow"
  widerow_file_format = "json"

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

module "sf_loader" {
  source  = "snowplow-devops/snowflake-loader-ec2/aws"
  version = "0.3.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.snowflake_enabled ? 1 : 0

  name       = "${var.prefix}-sf-loader-server"
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids

  sqs_queue_name = aws_sqs_queue.sf_message_queue[0].name

  snowflake_loader_user        = var.snowflake_loader_user
  snowflake_password           = var.snowflake_loader_password
  snowflake_warehouse          = var.snowflake_warehouse
  snowflake_database           = var.snowflake_database
  snowflake_schema             = var.snowflake_schema
  snowflake_region             = var.snowflake_region
  snowflake_account            = var.snowflake_account
  snowflake_aws_s3_bucket_name = local.s3_pipeline_bucket_name

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
