# 0. Setup key for SSH into deployed servers
resource "aws_key_pair" "pipeline" {
  key_name   = "${var.prefix}-iglu_server"
  public_key = var.ssh_public_key
}

# 1. Deploy an Iglu Server stack
module "iglu_rds" {
  source  = "snowplow-devops/rds/aws"
  version = "0.5.0"

  name        = "${var.prefix}-iglu-rds"
  vpc_id      = var.vpc_id
  subnet_ids  = var.private_subnet_ids
  db_name     = var.iglu_db_name
  db_username = var.iglu_db_username
  db_password = var.iglu_db_password

  ca_cert_identifier = "rds-ca-rsa2048-g1"

  tags = var.tags
}

module "iglu_lb" {
  source  = "snowplow-devops/alb/aws"
  version = "0.2.0"

  name              = "${var.prefix}-iglu-lb"
  vpc_id            = var.vpc_id
  subnet_ids        = var.public_subnet_ids
  health_check_path = "/api/meta/health"

  ssl_certificate_arn     = var.ssl_information.certificate_arn
  ssl_certificate_enabled = var.ssl_information.enabled

  tags = var.tags
}

module "iglu_server" {
  source  = "snowplow-devops/iglu-server-ec2/aws"
  version = "0.5.0"

  accept_limited_use_license = var.accept_limited_use_license

  app_version = "0.14.0"

  name                 = "${var.prefix}-iglu-server"
  vpc_id               = var.vpc_id
  subnet_ids           = var.private_subnet_ids
  iglu_server_lb_sg_id = module.iglu_lb.sg_id
  iglu_server_lb_tg_id = module.iglu_lb.tg_id
  ingress_port         = module.iglu_lb.tg_egress_port
  db_sg_id             = module.iglu_rds.sg_id
  db_host              = module.iglu_rds.address
  db_port              = module.iglu_rds.port
  db_name              = var.iglu_db_name
  db_username          = var.iglu_db_username
  db_password          = var.iglu_db_password
  super_api_key        = var.iglu_super_api_key

  ssh_key_name     = aws_key_pair.pipeline.key_name
  ssh_ip_allowlist = var.ssh_ip_allowlist

  iam_permissions_boundary = var.iam_permissions_boundary

  telemetry_enabled = var.telemetry_enabled
  user_provided_id  = var.user_provided_id

  associate_public_ip_address = false

  tags = var.tags

  cloudwatch_logs_enabled        = var.cloudwatch_logs_enabled
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
}
