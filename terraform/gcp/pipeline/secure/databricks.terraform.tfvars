# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "sp"

# The project to deploy the infrastructure into
project_id = "PROJECT_ID_TO_DEPLOY_INTO"

# Where to deploy the infrastructure
region = "REGION_TO_DEPLOY_INTO"

# --- Network
# NOTE: The network & sub-network configured must be configured with a Cloud NAT to allow the deployed Compute Engine instances to
#       connect to the internet to download the required assets
network    = "YOUR_NETWORK_HERE"
subnetwork = "YOUR_SUB_NETWORK_HERE"

# --- SSH
# Update this to your IP Address
ssh_ip_allowlist = ["999.999.999.999/32"]
# Generate a new SSH key locally with `ssh-keygen`
# ssh-keygen -t rsa -b 4096 
ssh_key_pairs = [
  {
    user_name  = "snowplow"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA0jSi9//bRsHW4M6czodTs6smCXsxZ0gijzth0aBmycE= snowplow@Snowplows-MacBook-Pro.local"
  }
]

# --- Iglu Server Configuration
# Iglu Server DNS output from the Iglu Server stack
iglu_server_dns_name = "http://CHANGE-TO-MY-IGLU-IP"
# Used for API actions on the Iglu Server
# Change this to the same UUID from when you created the Iglu Server
iglu_super_api_key = "00000000-0000-0000-0000-000000000000"

# --- Snowplow Databricks Loader
pipeline_db                   = "databricks"
deltalake_catalog             = "DB_CATALOG"
deltalake_schema              = "DB_SCHEMA"
deltalake_host                = "DB_HOST"
deltalake_port                = "DB_PORT"
deltalake_http_path           = "DB_HTTP_PATH"
deltalake_auth_token          = "DB_AUTH_TOKEN"
transformer_window_period_min = 10
transformer_bucket_name       = "transformer-bucket"
databricks_callback_iam       = "DB_CALLBACK_IAM"

# See for more information: https://registry.terraform.io/modules/snowplow-devops/collector-pubsub-ce/google/latest#telemetry
# Telemetry principles: https://docs.snowplowanalytics.com/docs/open-source-quick-start/what-is-the-quick-start-for-open-source/telemetry-principles/
user_provided_id  = ""
telemetry_enabled = true

# --- SSL Configuration (optional)
ssl_information = {
  certificate_id = ""
  enabled        = false
}

# --- Extra Labels to append to created resources (optional)
labels = {}
