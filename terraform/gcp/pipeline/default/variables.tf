variable "prefix" {
  description = "Will be prefixed to all resource names. Use to easily identify the resources created"
  type        = string
}

variable "project_id" {
  description = "The project ID in which the stack is being deployed"
  type        = string
}

variable "region" {
  description = "The name of the region to deploy within"
  type        = string
}

variable "network" {
  description = "The name of the network to deploy within"
  type        = string
}

variable "subnetwork" {
  description = "The name of the sub-network to deploy within"
  type        = string
}

variable "ssh_key_pairs" {
  description = "The list of SSH key-pairs to add to the servers"
  default     = []
  type = list(object({
    user_name  = string
    public_key = string
  }))
}

variable "ssh_ip_allowlist" {
  description = "The list of CIDR ranges to allow SSH traffic from"
  type        = list(any)
}

variable "iglu_server_dns_name" {
  description = "The DNS name of your Iglu Server"
  type        = string
}

variable "iglu_super_api_key" {
  description = "A UUIDv4 string to use as the master API key for Iglu Server management"
  type        = string
  sensitive   = true
}

variable "pipeline_db" {
  type        = string
  description = "Database used by pipeline"

  validation {
    condition     = can(regex("^(postgres|bigquery|snowflake|databricks)$", var.pipeline_db))
    error_message = "Must be postgres or bigquery or snowflake or databricks."
  }
}

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

variable "postgres_db_authorized_networks" {
  description = "The list of CIDR ranges to allow access to the Pipeline Database over"
  default     = []
  type = list(object({
    name  = string
    value = string
  }))
}

variable "postgres_db_tier" {
  description = "The instance type to assign to the deployed Cloud SQL instance"
  type        = string
  default     = "db-g1-small"
}

variable "bigquery_db_enabled" {
  description = "Whether to enable loading into a BigQuery Dataset"
  default     = false
  type        = bool
}

variable "bigquery_loader_dead_letter_bucket_deploy" {
  description = "Whether this module should create a new bucket with the specified name - if the bucket already exists set this to false"
  default     = true
  type        = bool
}

variable "bigquery_loader_dead_letter_bucket_name" {
  description = "The name of the GCS bucket to use for dead-letter output of loader"
  default     = ""
  type        = string
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

variable "ssl_information" {
  description = "The ID of an Google Managed certificate to bind to the load balancer"
  type = object({
    enabled        = bool
    certificate_id = string
  })
  default = {
    certificate_id = ""
    enabled        = false
  }
}

variable "labels" {
  description = "The labels to append to the resources in this module"
  default     = {}
  type        = map(string)
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

variable "snowflake_loader_role" {
  description = "Snowflake role for loading snowplow data"
  type        = string
  default     = ""
}

variable "snowflake_warehouse" {
  description = "Snowflake warehouse name"
  type        = string
  default     = ""
}

variable "snowflake_transformed_stage_name" {
  description = "Name of transformed stage"
  type        = string
  default     = ""
}

variable "snowflake_callback_iam" {
  description = "Snowflake callback IAM from STORAGE INTEGRATION"
  type        = string
  default     = ""
}

variable "transformer_window_period_min" {
  description = "Frequency to emit transforming finished message - 5,10,15,20,30,60 etc minutes"
  type        = number
  default     = 5
}

variable "transformer_bucket_name" {
  description = "Transformer bucket name, prefixed with the prefix value"
  type        = string
  default     = "qs-transformed"
}

variable "deltalake_catalog" {
  description = "Databricks deltalake catalog"
  type        = string
  default     = "hive_metastore"
}

variable "deltalake_schema" {
  description = "Databricks deltalake schema"
  type        = string
  default     = ""
}

variable "deltalake_host" {
  description = "Databricks deltalake host"
  type        = string
  default     = ""
}

variable "deltalake_port" {
  description = "Databricks deltalake port"
  type        = string
  default     = ""
}

variable "deltalake_http_path" {
  description = "Databricks deltalake http path"
  type        = string
  default     = ""
}

variable "deltalake_auth_token" {
  description = "Databricks deltalake auth token"
  type        = string
  default     = ""
  sensitive   = true
}

variable "databricks_callback_iam" {
  description = "Databricks callback IAM to allow access to GCS bucket"
  type        = string
}
