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

variable "resource_group_name" {
  description = "The name of the resource group to deploy resources within"
  type        = string
}

variable "subnet_id_lb" {
  description = "The ID of the subnet to deploy the load balancer into (e.g. iglu-agw1)"
  type        = string
}

variable "subnet_id_servers" {
  description = "The ID of the subnet to deploy the servers into (e.g. iglu1)"
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

variable "iglu_db_name" {
  description = "The name of the database to create"
  type        = string
}

variable "iglu_db_username" {
  description = "The username to use to connect to the database"
  type        = string
}

variable "iglu_db_password" {
  description = "The password to use to connect to the database"
  type        = string
  sensitive   = true
}

variable "iglu_super_api_key" {
  description = "A UUIDv4 string to use as the master API key for Iglu Server management"
  type        = string
  sensitive   = true
}

variable "iglu_db_ip_allowlist" {
  description = "An optional list of CIDR ranges to allow traffic from"
  type        = list(any)
  default     = []
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
