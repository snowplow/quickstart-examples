# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "snowplow"

# WARNING: You MUST change this as each account must be globally unique
storage_account_name = "snowplowstorage1"

# To use an existing account set this to false and update the name above
storage_account_deploy = true

# The name of the resource group to deploy the pipeline into
resource_group_name = "<ADD_ME>"

# ID of the dedicated subnet to deploy the load balancer into
subnet_id_lb = "<SET_ME>"

# ID of the subnet to deploy the actual pipeline applications into
subnet_id_servers = "<SET_ME>"

# Update this to _your_ IP Address
ssh_ip_allowlist = ["999.999.999.999/32"]
# Generate a new SSH key locally with `ssh-keygen`
# ssh-keygen -t rsa -b 4096 
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA0jSi9//bRsHW4M6czodTs6smCXsxZ0gijzth0aBmycE= snowplow@Snowplows-MacBook-Pro.local"

# Iglu Server DNS output from the Iglu Server stack
iglu_server_dns_name = "http://<CHANGE-TO-MY-IGLU-DNS-NAME>"
# Used for API actions on the Iglu Server
# Change this to the same UUID from when you created the Iglu Server
iglu_super_api_key = "00000000-0000-0000-0000-000000000000"

# SSL Configuration (optional)
ssl_information = {
  password = ""
  data     = ""
  enabled  = false
}

# --- Target: Snowflake
# Follow the guide to get input values for the loader:
# https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/quick-start/
snowflake_enabled = false

snowflake_account         = "<ACCOUNT>"
snowflake_region          = "<REGION>"
snowflake_loader_user     = "<USER>"
snowflake_loader_password = "<PASSWORD>"
snowflake_database        = "<DATABASE>"
snowflake_schema          = "<SCHEMA>"
snowflake_warehouse       = "<WAREHOUSE>"
# This controls how often data will be loading into Snowflake
snowflake_transformer_window_period_min = 1

# --- ADVANCED CONFIGURATION ZONE --- #

# Telemetry principles: https://docs.snowplowanalytics.com/docs/open-source-quick-start/what-is-the-quick-start-for-open-source/telemetry-principles/
user_provided_id  = ""
telemetry_enabled = true

# Extra Tags to append to created resources (optional)
tags = {}
