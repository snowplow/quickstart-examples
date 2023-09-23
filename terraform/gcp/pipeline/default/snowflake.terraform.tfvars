# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "sp"

# The project to deploy the infrastructure into
project_id = "PROJECT_ID_TO_DEPLOY_INTO"

# Where to deploy the infrastructure
region = "REGION_TO_DEPLOY_INTO"

# --- Default Network
# Update to the network you would like to deploy into
#
# Note: If you opt to use your own network then you will need to define a subnetwork to deploy into as well
network    = "default"
subnetwork = ""

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

# --- Snowplow Snowflake Loader
pipeline_db       = "snowflake"
snowflake_account = "sf_account"
snowflake_region  = "us-west-2"
# Change and keep this secret!
snowflake_loader_password        = "Hell0W0rld!2"
snowflake_database               = "SF_DB_NAME"
snowflake_loader_role            = "SF_LOADER_ROLE"
snowflake_loader_user            = "SF_LOADER_USER"
snowflake_schema                 = "ATOMIC"
snowflake_transformed_stage_name = "SF_TRANSFORMED_STAGE"
snowflake_warehouse              = "SF_WAREHOUSE"
transformer_window_period_min    = 10
transformer_bucket_name          = "transformer-bucket"
snowflake_callback_iam           = "SF_CALLBACK_IAM"

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
