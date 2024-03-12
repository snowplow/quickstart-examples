module "snowflake_streaming_loader_enriched" {
  source  = "snowplow-devops/snowflake-streaming-loader-ec2/aws"
  version = "0.1.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.snowflake_streaming_enabled ? 1 : 0

  name       = "${var.prefix}-sf-streaming-enriched"
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  in_stream_name  = module.enriched_stream.name
  bad_stream_name = module.bad_1_stream.name

  snowflake_account_url = var.snowflake_streaming_account_url
  snowflake_loader_user = var.snowflake_streaming_loader_user
  snowflake_private_key = var.snowflake_streaming_loader_private_key
  snowflake_database    = var.snowflake_streaming_database
  snowflake_schema      = var.snowflake_streaming_schema

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  iam_permissions_boundary = var.iam_permissions_boundary

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  associate_public_ip_address = false

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}
