variable "prefix" {
  description = "Will be prefixed to all resource names. Use to easily identify the resources created"
  type        = string
}

variable "tags" {
  description = "The tags to append to the resources in this module"
  default     = {}
  type        = map(string)
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket events will be loaded into"
  type        = string
}

variable "s3_bucket_object_prefix" {
  description = "An optional prefix under which Snowplow data will be saved (Note: your prefix must end with a trailing '/')"
  type        = string
  default     = ""
}

variable "iam_permissions_boundary" {
  description = "The permissions boundary ARN to set on IAM roles created"
  default     = ""
  type        = string
}

variable "snowflake_operator_username" {
  description = "Snowflake username to pass Snowflake TF provider"
  type        = string
}

variable "snowflake_account" {
  description = "Snowflake account to use"
  type        = string
}

variable "snowflake_region" {
  description = "Region of Snowflake account"
  type        = string
}

variable "snowflake_operator_user_role" {
  description = "Snowflake user role to pass Snowflake TF provider"
  type        = string
}

variable "snowflake_private_key_path" {
  description = "Private key for accessing Snowflake"
  type        = string
}

variable "snowflake_file_format_name" {
  description = "Name of the Snowflake file format which is used by stage"
  default     = "SNOWPLOW_ENRICHED_JSON"
  type        = string
}

variable "is_create_database" {
  description = "Should database be created. Set to false, to use an existing one"
  default     = true
  type        = bool
}

variable "snowflake_loader_password" {
  description = "The password to use for the loader user"
  type        = string
  sensitive   = true
}

variable "snowflake_wh_size" {
  description = "Size of the Snowflake warehouse to connect to"
  default     = "XSMALL"
  type        = string
}

variable "snowflake_wh_auto_suspend" {
  description = "Time period to wait before suspending warehouse"
  default     = 60
  type        = number
}

variable "snowflake_wh_auto_resume" {
  description = "Whether to enable auto resume which makes automatically resume the warehouse when any statement that requires a warehouse is submitted "
  default     = true
  type        = bool
}

variable "override_snowflake_db_name" {
  description = "Override database name. If not set it will be defaulted to uppercase var.name with \"_DATABASE\" suffix"
  default     = ""
  type        = string
}

variable "override_snowflake_schema" {
  description = "Override snowflake schema"
  default     = "ATOMIC"
  type        = string
}

variable "override_snowflake_loader_user" {
  description = "Override loader user name in snowflake, if not set it will be uppercase var.name with _LOADER_USER suffix"
  default     = ""
  type        = string
}

variable "override_snowflake_wh_name" {
  description = "Override warehouse name, if not set it will be defaulted to uppercase var.name with \"_WAREHOUSE\" suffix"
  default     = ""
  type        = string
}

variable "override_iam_loader_role_name" {
  description = "Override transformed stage url, if not set it will be var.name with -snowflakedb-load-role suffix"
  default     = ""
  type        = string
}

variable "override_snowflake_loader_role" {
  description = "Override loader role name in snowflake, if not set it will be uppercase var.name with \"_LOADER_ROLE\" suffix"
  default     = ""
  type        = string
}
