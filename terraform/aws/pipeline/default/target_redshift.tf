resource "aws_sqs_queue" "rs_message_queue" {
  count = var.redshift_enabled ? 1 : 0

  content_based_deduplication = true
  name                        = "${var.prefix}-rs-loader.fifo"
  fifo_queue                  = true
  kms_master_key_id           = "alias/aws/sqs"
}

module "rs_transformer_stsv" {
  source  = "snowplow-devops/transformer-kinesis-ec2/aws"
  version = "0.4.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.redshift_enabled ? 1 : 0

  name       = "${var.prefix}-transformer-server-stsv"
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids

  stream_name             = module.enriched_stream.name
  s3_bucket_name          = local.s3_pipeline_bucket_name
  s3_bucket_object_prefix = "${var.s3_bucket_object_prefix}transformed/good/shredded/tsv"
  window_period_min       = var.redshift_transformer_window_period_min
  sqs_queue_name          = aws_sqs_queue.rs_message_queue[0].name

  transformation_type  = "shred"
  default_shred_format = "TSV"

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

module "rs_loader" {
  source  = "snowplow-devops/redshift-loader-ec2/aws"
  version = "0.2.0"

  accept_limited_use_license = var.accept_limited_use_license

  count = var.redshift_enabled ? 1 : 0

  name       = "${var.prefix}-rs-loader-server"
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids

  sqs_queue_name = aws_sqs_queue.rs_message_queue[0].name

  redshift_host               = var.redshift_host
  redshift_database           = var.redshift_database
  redshift_port               = var.redshift_port
  redshift_schema             = var.redshift_schema
  redshift_loader_user        = var.redshift_loader_user
  redshift_password           = var.redshift_loader_password
  redshift_aws_s3_bucket_name = local.s3_pipeline_bucket_name

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
