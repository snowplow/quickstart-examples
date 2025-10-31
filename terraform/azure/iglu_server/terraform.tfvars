# Please accept the terms of the Snowplow Limited Use License Agreement to proceed. (https://docs.snowplow.io/limited-use-license-1.0/)
accept_limited_use_license = false

# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "snowplow"

# The name of the resource group to deploy Iglu into
resource_group_name = "<ADD_ME>"

# ID of the VNet being deployed into
vnet_id = "<SET_ME>"

# ID of the dedicated subnet to deploy the load balancer into
subnet_id_lb = "<SET_ME>"

# ID of the subnet to deploy the actual Iglu Server database into
subnet_id_database = "<SET_ME>"

# ID of the subnet to deploy the actual Iglu Server application into
subnet_id_servers = "<SET_ME>"

# Update this to _your_ IP Address
ssh_ip_allowlist = ["999.999.999.999/32"]
# Generate a new SSH key locally with `ssh-keygen`
# ssh-keygen -t rsa -b 4096 
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA0jSi9//bRsHW4M6czodTs6smCXsxZ0gijzth0aBmycE= snowplow@Snowplows-MacBook-Pro.local"

# Iglu Server settings
iglu_db_name     = "iglu"
iglu_db_username = "iglu"
# Change and keep this secret!
iglu_db_password = "<PASSWORD>"

# Used for API actions on the Iglu Server
# Change this to a new UUID and keep it secret!
iglu_super_api_key = "00000000-0000-0000-0000-000000000000"

# NOTE: To push schemas to your Iglu Server, you can use igluctl
# See the docs: https://docs.snowplow.io/docs/understanding-tracking-design/managing-your-data-structures/iglu/

# Telemetry principles: https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/telemetry/
user_provided_id  = ""
telemetry_enabled = true

# SSL Configuration (optional)
ssl_information = {
  password = ""
  data     = ""
  enabled  = false
}

# Extra Tags to append to created resources (optional)
tags = {}
