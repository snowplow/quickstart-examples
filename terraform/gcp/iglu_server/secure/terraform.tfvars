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
# Update this to the internal IP of your Bastion Host
ssh_ip_allowlist = ["999.999.999.999/32"]
# Generate a new SSH key locally with `ssh-keygen`
# ssh-keygen -t rsa -b 4096 
ssh_key_pairs = [
  {
    user_name  = "snowplow"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA0jSi9//bRsHW4M6czodTs6smCXsxZ0gijzth0aBmycE= snowplow@Snowplows-MacBook-Pro.local"
  }
]

# --- Snowplow Iglu Server
iglu_db_name     = "iglu"
iglu_db_username = "iglu"
# Change and keep this secret!
iglu_db_password = "Hell0W0rld!"

# Used for API actions on the Iglu Server
# Change this to a new UUID and keep it secret!
iglu_super_api_key = "00000000-0000-0000-0000-000000000000"

# NOTE: To push schemas to your Iglu Server, you can use igluctl
# igluctl: https://docs.snowplowanalytics.com/docs/pipeline-components-and-applications/iglu/igluctl
# igluctl static push --public schemas/ http://CHANGE-TO-MY-IGLU-IP 00000000-0000-0000-0000-000000000000

# See for more information: https://github.com/snowplow-devops/terraform-google-iglu-server-ce#telemetry
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
