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

# --- Snowplow Postgres Loader
postgres_db_enabled  = true

postgres_db_name     = "snowplow"
postgres_db_username = "snowplow"
# Change and keep this secret!
postgres_db_password = "Hell0W0rld!2"
# IP ranges that you want to query the Pipeline Postgres Cloud SQL instance from directly over the internet.  An alternative access method is to leverage
# the Cloud SQL Proxy service which creates an IAM authenticated tunnel to the instance
#
# Details: https://cloud.google.com/sql/docs/postgres/sql-proxy
#
# Note: this exposes your data to the internet - take care to ensure your allowlist is strict enough
postgres_db_authorized_networks = [
  {
    name  = "foo"
    value = "999.999.999.999/32"
  },
  {
    name  = "bar"
    value = "888.888.888.888/32"
  }
]
# Note: the size of the database instance determines the number of concurrent connections - each Postgres Loader instance creates 10 open connections so having
# a sufficiently powerful database tier is important to not running out of connection slots
postgres_db_tier = "db-g1-small"

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
