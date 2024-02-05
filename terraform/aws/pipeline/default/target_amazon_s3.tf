module "s3_loader_raw" {
  source  = "snowplow-devops/s3-loader-kinesis-ec2/aws"
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.s3_raw_enabled ? 1 : 0

  name             = "${var.prefix}-s3-loader-raw-server"
  vpc_id           = var.vpc_id
  subnet_ids       = var.public_subnet_ids
  in_stream_name   = module.raw_stream.name
  bad_stream_name  = module.bad_1_stream.name
  s3_bucket_name   = local.s3_pipeline_bucket_name
  s3_object_prefix = "${var.s3_bucket_object_prefix}raw/"

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  iam_permissions_boundary = var.iam_permissions_boundary

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}

module "s3_loader_bad" {
  source  = "snowplow-devops/s3-loader-kinesis-ec2/aws"
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.s3_bad_enabled ? 1 : 0

  name             = "${var.prefix}-s3-loader-bad-server"
  vpc_id           = var.vpc_id
  subnet_ids       = var.public_subnet_ids
  in_stream_name   = module.bad_1_stream.name
  bad_stream_name  = module.bad_2_stream.name
  s3_bucket_name   = local.s3_pipeline_bucket_name
  s3_object_prefix = "${var.s3_bucket_object_prefix}bad/partitioned/"

  purpose          = "SELF_DESCRIBING"
  partition_format = "{vendor}.{schema}"

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  iam_permissions_boundary = var.iam_permissions_boundary

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}

module "s3_loader_enriched" {
  source  = "snowplow-devops/s3-loader-kinesis-ec2/aws"
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.s3_enriched_enabled ? 1 : 0

  name             = "${var.prefix}-s3-loader-enriched-server"
  vpc_id           = var.vpc_id
  subnet_ids       = var.public_subnet_ids
  in_stream_name   = module.enriched_stream.name
  bad_stream_name  = module.bad_1_stream.name
  s3_bucket_name   = local.s3_pipeline_bucket_name
  s3_object_prefix = "${var.s3_bucket_object_prefix}enriched/"

  purpose = "ENRICHED_EVENTS"

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  iam_permissions_boundary = var.iam_permissions_boundary

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}
