locals {
  custom_iglu_resolvers = [
    {
      name            = "Iglu Server"
      priority        = 0
      uri             = "${var.iglu_server_dns_name}/api"
      api_key         = var.iglu_super_api_key
      vendor_prefixes = []
    }
  ]
}

module "s3_pipeline_bucket" {
  source  = "snowplow-devops/s3-bucket/aws"
  version = "0.1.1"

  count = var.s3_bucket_deploy ? 1 : 0

  bucket_name = var.s3_bucket_name

  tags = var.tags
}

# 0. Setup key for SSH into deployed servers
resource "aws_key_pair" "pipeline" {
  key_name   = "${var.prefix}-pipeline"
  public_key = var.ssh_public_key
}

# 1. Deploy Kinesis streams
module "raw_stream" {
  source  = "snowplow-devops/kinesis-stream/aws"
  version = "0.1.1"

  name = "${var.prefix}-raw-stream"

  tags = var.tags
}

module "bad_1_stream" {
  source  = "snowplow-devops/kinesis-stream/aws"
  version = "0.1.1"

  name = "${var.prefix}-bad-1-stream"

  tags = var.tags
}

module "enriched_stream" {
  source  = "snowplow-devops/kinesis-stream/aws"
  version = "0.1.1"

  name = "${var.prefix}-enriched-stream"

  tags = var.tags
}

module "bad_2_stream" {
  source  = "snowplow-devops/kinesis-stream/aws"
  version = "0.1.1"

  name = "${var.prefix}-bad-2-stream"

  tags = var.tags
}

# 2. Deploy Collector stack
module "collector_lb" {
  source  = "snowplow-devops/alb/aws"
  version = "0.1.2"

  name              = "${var.prefix}-collector-lb"
  vpc_id            = var.vpc_id
  subnet_ids        = var.public_subnet_ids
  health_check_path = "/health"

  ssl_certificate_arn     = var.ssl_information.certificate_arn
  ssl_certificate_enabled = var.ssl_information.enabled

  tags = var.tags
}

module "collector_kinesis" {
  source  = "snowplow-devops/collector-kinesis-ec2/aws"
  version = "0.2.1"

  name               = "${var.prefix}-collector-server"
  vpc_id             = var.vpc_id
  subnet_ids         = var.public_subnet_ids
  collector_lb_sg_id = module.collector_lb.sg_id
  collector_lb_tg_id = module.collector_lb.tg_id
  ingress_port       = module.collector_lb.tg_egress_port
  good_stream_name   = module.raw_stream.name
  bad_stream_name    = module.bad_1_stream.name

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  iam_permissions_boundary = var.iam_permissions_boundary

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}

# 3. Deploy Enrichment
module "enrich_kinesis" {
  source  = "snowplow-devops/enrich-kinesis-ec2/aws"
  version = "0.2.1"

  name                 = "${var.prefix}-enrich-server"
  vpc_id               = var.vpc_id
  subnet_ids           = var.public_subnet_ids
  in_stream_name       = module.raw_stream.name
  enriched_stream_name = module.enriched_stream.name
  bad_stream_name      = module.bad_1_stream.name

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  iam_permissions_boundary = var.iam_permissions_boundary

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  # Linking in the custom Iglu Server here
  custom_iglu_resolvers = local.custom_iglu_resolvers

  kcl_write_max_capacity = var.pipeline_kcl_write_max_capacity

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}

# 4. Save raw, enriched and bad data to Amazon S3
module "s3_loader_raw" {
  source  = "snowplow-devops/s3-loader-kinesis-ec2/aws"
  version = "0.2.1"

  name             = "${var.prefix}-s3-loader-raw-server"
  vpc_id           = var.vpc_id
  subnet_ids       = var.public_subnet_ids
  in_stream_name   = module.raw_stream.name
  bad_stream_name  = module.bad_1_stream.name
  s3_bucket_name   = join("", module.s3_pipeline_bucket.*.id)
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
  version = "0.2.1"

  name             = "${var.prefix}-s3-loader-bad-server"
  vpc_id           = var.vpc_id
  subnet_ids       = var.public_subnet_ids
  in_stream_name   = module.bad_1_stream.name
  bad_stream_name  = module.bad_2_stream.name
  s3_bucket_name   = join("", module.s3_pipeline_bucket.*.id)
  s3_object_prefix = "${var.s3_bucket_object_prefix}bad/"

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
  version = "0.2.1"

  name             = "${var.prefix}-s3-loader-enriched-server"
  vpc_id           = var.vpc_id
  subnet_ids       = var.public_subnet_ids
  in_stream_name   = module.enriched_stream.name
  bad_stream_name  = module.bad_1_stream.name
  s3_bucket_name   = join("", module.s3_pipeline_bucket.*.id)
  s3_object_prefix = "${var.s3_bucket_object_prefix}enriched/"

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
