variable "accept_limited_use_license" {
  description = "Acceptance of the SLULA terms (https://docs.snowplow.io/limited-use-license-1.0/)"
  type        = bool
  default     = false

  validation {
    condition     = var.accept_limited_use_license
    error_message = "Please accept the terms of the Snowplow Limited Use License Agreement to proceed."
  }
}

variable "prefix" {
  description = "Will be prefixed to all resource names. Use to easily identify the resources created"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket events will be loaded into"
  type        = string
}

variable "s3_bucket_deploy" {
  description = "Whether this module should create a new bucket with the specified name - if the bucket already exists set this to false"
  type        = bool
  default     = true
}

variable "s3_bucket_object_prefix" {
  description = "An optional prefix under which Snowplow data will be saved (Note: your prefix must end with a trailing '/')"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The VPC to deploy the components within"
  type        = string
}

variable "public_subnet_ids" {
  description = "The list of public subnets to deploy the components across"
  type        = list(string)
}

variable "ssh_public_key" {
  description = "The SSH public key to use for the deployment"
  type        = string
}

variable "ssh_ip_allowlist" {
  description = "The list of CIDR ranges to allow SSH traffic from"
  type        = list(any)
}

variable "iglu_server_dns_name" {
  description = "The DNS name of your Iglu Server"
  type        = string

  validation {
    condition     = can(regex("^http[s]?://.*$", var.iglu_server_dns_name))
    error_message = "Value must contain a http/s prefix"
  }
}

variable "iglu_super_api_key" {
  description = "A UUIDv4 string to use as the master API key for Iglu Server management"
  type        = string
  sensitive   = true
}

variable "pipeline_kcl_write_max_capacity" {
  description = "Increasing this is important to increase throughput at very high pipeline volumes"
  type        = number
  default     = 50
}

variable "telemetry_enabled" {
  description = "Whether or not to send telemetry information back to Snowplow Analytics Ltd"
  type        = bool
  default     = true
}

variable "user_provided_id" {
  description = "An optional unique identifier to identify the telemetry events emitted by this stack"
  default     = ""
  type        = string
}

variable "iam_permissions_boundary" {
  description = "The permissions boundary ARN to set on IAM roles created"
  default     = ""
  type        = string
}

variable "ssl_information" {
  description = "The ARN of an Amazon Certificate Manager certificate to bind to the load balancer"
  type = object({
    enabled         = bool
    certificate_arn = string
  })
  default = {
    certificate_arn = ""
    enabled         = false
  }
}

variable "tags" {
  description = "The tags to append to the resources in this module"
  default     = {}
  type        = map(string)
}

variable "cloudwatch_logs_enabled" {
  description = "Whether application logs should be reported to CloudWatch"
  default     = true
  type        = bool
}

variable "cloudwatch_logs_retention_days" {
  description = "The length of time in days to retain logs for"
  default     = 7
  type        = number
}

# --- Target: Amazon S3

variable "s3_raw_enabled" {
  description = "Whether to enable loading of raw data into S3 from Kinesis"
  default     = false
  type        = bool
}

variable "s3_bad_enabled" {
  description = "Whether to enable loading of bad data into S3 from Kinesis"
  default     = true
  type        = bool
}

variable "s3_enriched_enabled" {
  description = "Whether to enable loading of enriched data into S3 from Kinesis"
  default     = true
  type        = bool
}

# --- Target: PostgreSQL

variable "postgres_db_enabled" {
  description = "Whether to enable loading into a Postgres Database"
  default     = false
  type        = bool
}

variable "postgres_db_name" {
  description = "The name of the database to connect to"
  type        = string
  default     = ""
}

variable "postgres_db_username" {
  description = "The username to use to connect to the database"
  type        = string
  default     = ""
}

variable "postgres_db_password" {
  description = "The password to use to connect to the database"
  type        = string
  sensitive   = true
  default     = ""
}

variable "postgres_db_publicly_accessible" {
  description = "Whether to make the Postgres RDS instance accessible over the internet"
  type        = bool
  default     = false
}

variable "postgres_db_ip_allowlist" {
  description = "An optional list of CIDR ranges to allow traffic from"
  type        = list(any)
  default     = []
}

# --- Target: SnowflakeDB

variable "snowflake_enabled" {
  description = "Whether to enable loading into a Snowflake Database"
  default     = false
  type        = bool
}

variable "snowflake_account" {
  description = "Snowflake account to use"
  type        = string
  default     = ""
}

variable "snowflake_region" {
  description = "Region of Snowflake account"
  type        = string
  default     = ""
}

variable "snowflake_loader_password" {
  description = "The password to use for the loader user"
  type        = string
  sensitive   = true
  default     = ""
}

variable "snowflake_loader_user" {
  description = "The Snowflake user used by Snowflake Loader"
  type        = string
  default     = ""
}

variable "snowflake_database" {
  description = "Snowflake database name"
  type        = string
  default     = ""
}

variable "snowflake_schema" {
  description = "Snowflake schema name"
  type        = string
  default     = ""
}

variable "snowflake_warehouse" {
  description = "Snowflake warehouse name"
  type        = string
  default     = ""
}

variable "snowflake_transformer_window_period_min" {
  description = "Frequency to emit transforming finished message - 5,10,15,20,30,60 etc minutes"
  type        = number
  default     = 5
}

# --- Target: Databricks

variable "databricks_enabled" {
  description = "Whether to enable loading into a Databricks Database"
  default     = false
  type        = bool
}

variable "databricks_catalog" {
  description = "Databricks deltalake catalog"
  type        = string
  default     = "hive_metastore"
}

variable "databricks_schema" {
  description = "Databricks deltalake schema"
  type        = string
  default     = ""
}

variable "databricks_host" {
  description = "Databricks deltalake host"
  type        = string
  default     = ""
}

variable "databricks_port" {
  description = "Databricks deltalake port"
  type        = number
  default     = 443
}

variable "databricks_http_path" {
  description = "Databricks deltalake http path"
  type        = string
  default     = ""
}

variable "databricks_auth_token" {
  description = "Databricks deltalake auth token"
  type        = string
  sensitive   = true
  default     = ""
}

variable "databricks_transformer_window_period_min" {
  description = "Frequency to emit transforming finished message - 5,10,15,20,30,60 etc minutes"
  type        = number
  default     = 5
}

# --- Target: Redshift

variable "redshift_enabled" {
  description = "Whether to enable loading into a Redshift Database"
  default     = false
  type        = bool
}

variable "redshift_host" {
  description = "Redshift cluster hostname"
  type        = string
  default     = ""
}

variable "redshift_database" {
  description = "Redshift database name"
  type        = string
  default     = ""
}

variable "redshift_port" {
  description = "Redshift port"
  type        = number
  default     = 5439
}

variable "redshift_schema" {
  description = "Redshift schema name"
  type        = string
  default     = ""
}

variable "redshift_loader_user" {
  description = "Name of the user that will be used for loading data"
  type        = string
  default     = ""
}

variable "redshift_loader_password" {
  description = "Password for redshift_loader_user used by loader to perform loading"
  type        = string
  sensitive   = true
}

variable "redshift_transformer_window_period_min" {
  description = "Frequency to emit transforming finished message - 5,10,15,20,30,60 etc minutes"
  type        = number
  default     = 5
}
