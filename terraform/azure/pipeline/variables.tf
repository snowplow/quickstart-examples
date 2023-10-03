variable "prefix" {
  description = "Will be prefixed to all resource names. Use to easily identify the resources created"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Storage Account the data will be loaded into"
  type        = string
}

variable "storage_account_deploy" {
  description = "Whether this module should create a new storage account with the specified name - if the account already exists set this to false"
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "The name of the resource group to deploy resources within"
  type        = string
}

variable "subnet_id_lb" {
  description = "The ID of the subnet to deploy the load balancer into (e.g. collector-agw1)"
  type        = string
}

variable "subnet_id_servers" {
  description = "The ID of the subnet to deploy the servers into (e.g. pipeline1)"
  type        = string
}

variable "ssh_public_key" {
  description = "The SSH public key to use for the deployment"
  type        = string
}

variable "ssh_ip_allowlist" {
  description = "The list of CIDR ranges to allow SSH traffic from"
  type        = list(any)

  validation {
    condition     = length(var.ssh_ip_allowlist) > 0
    error_message = "At least one CIDR range must be supplied for SSH"
  }
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

variable "ssl_information" {
  description = "SSL certificate information to optionally bind to the load balancer"
  type = object({
    enabled  = bool
    data     = string
    password = string
  })
  default = {
    password = ""
    data     = ""
    enabled  = false
  }
  sensitive = true
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

variable "tags" {
  description = "The tags to append to the resources in this module"
  default     = {}
  type        = map(string)
}

# --- Stream Selection

variable "stream_type" {
  description = "The stream type to use as the Kafka Cluster between components (options: azure_event_hubs, confluent_cloud)"
  default     = "azure_event_hubs"
  type        = string
}

# --- Stream: Confluent Cloud

variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key"
  default     = ""
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  default     = ""
  type        = string
  sensitive   = true
}

variable "confluent_cloud_bootstrap_server" {
  description = "Confluent Cloud cluster bootstrap server"
  default     = ""
  type        = string
}

variable "confluent_cloud_raw_topic_name" {
  description = "Confluent Cloud 'raw' topic name"
  default     = "raw"
  type        = string
}

variable "confluent_cloud_enriched_topic_name" {
  description = "Confluent Cloud 'enriched' topic name"
  default     = "enriched"
  type        = string
}

variable "confluent_cloud_bad_1_topic_name" {
  description = "Confluent Cloud 'bad-1' topic name"
  default     = "bad-1"
  type        = string
}

variable "confluent_cloud_snowflake_loader_topic_name" {
  description = "Confluent Cloud 'snowflake-loader' topic name"
  default     = "snowflake-loader"
  type        = string
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

# --- Target: Lake

variable "lake_enabled" {
  description = "Whether to load all data into a Storage Container to build a data-lake based on Delta format"
  default     = false
  type        = bool
}
