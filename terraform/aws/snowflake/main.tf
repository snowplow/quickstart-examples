provider "snowflake" {
  username         = var.snowflake_operator_username
  account          = var.snowflake_account
  region           = var.snowflake_region
  role             = var.snowflake_operator_user_role
  private_key_path = var.snowflake_private_key_path
}

data "aws_caller_identity" "current" {}

# --- IAM: Roles & Permissions Snowflake
# --- Storage Integration
data "aws_iam_policy_document" "snowflake_load_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::${module.snowflake_loader_setup.aws_s3_bucket_name}",
      "arn:aws:s3:::${module.snowflake_loader_setup.aws_s3_bucket_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "snowflake_load_assume_role_policy_storage_integration" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [module.snowflake_loader_setup.aws_iam_storage_integration_user_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [module.snowflake_loader_setup.aws_storage_external_id]
    }
  }
}

resource "aws_iam_policy" "snowflakedb_load_policy" {
  name        = "${var.prefix}-snowflake-loader-pol"
  tags        = var.tags
  description = "Access policy for the Snowflake loading role"
  policy      = data.aws_iam_policy_document.snowflake_load_policy.json
}

resource "aws_iam_role" "snowflakedb_load_role" {
  name                 = module.snowflake_loader_setup.aws_iam_storage_integration_role_name
  tags                 = var.tags
  description          = "Role for the Snowplow Snowflake Loader to assume"
  max_session_duration = 43200
  assume_role_policy   = data.aws_iam_policy_document.snowflake_load_assume_role_policy_storage_integration.json
  permissions_boundary = var.iam_permissions_boundary
}

resource "aws_iam_role_policy_attachment" "snowflake_role_policy_attachment" {
  role       = aws_iam_role.snowflakedb_load_role.name
  policy_arn = aws_iam_policy.snowflakedb_load_policy.arn
}

module "snowflake_target" {
  source = "snowplow-devops/target/snowflake"
  version = "0.1.0"

  name                        = replace(var.prefix, "-", "_")
  snowflake_file_format_name  = var.snowflake_file_format_name
  is_create_database          = var.is_create_database
  override_snowflake_database = var.override_snowflake_db_name
  snowflake_schema            = var.override_snowflake_schema
  override_snowflake_user     = var.override_snowflake_loader_user
  snowflake_password          = var.snowflake_loader_password
}

module "snowflake_loader_setup" {
  source = "snowplow-devops/snowflake-loader-setup/aws"
  version = "0.1.0"

  name                           = replace(var.prefix, "-", "_")
  snowflake_database             = module.snowflake_target.snowflake_database
  snowflake_event_table          = module.snowflake_target.snowflake_event_table
  snowflake_file_format          = module.snowflake_target.snowflake_file_format
  snowflake_schema               = module.snowflake_target.snowflake_schema
  snowflake_user                 = module.snowflake_target.snowflake_user
  aws_account_id                 = data.aws_caller_identity.current.account_id
  stage_bucket                   = var.s3_bucket_name
  override_transformed_stage_url = "s3://${var.s3_bucket_name}/${var.s3_bucket_object_prefix}transformed/good"
  snowflake_wh_size              = var.snowflake_wh_size
  snowflake_wh_auto_suspend      = var.snowflake_wh_auto_suspend
  snowflake_wh_auto_resume       = var.snowflake_wh_auto_resume
  override_snowflake_wh_name     = var.override_snowflake_wh_name
  override_iam_loader_role_name  = var.override_iam_loader_role_name
  override_snowflake_loader_user = var.override_snowflake_loader_user
  override_snowflake_loader_role = var.override_snowflake_loader_role
}
