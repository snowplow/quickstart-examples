# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "pipeline"

# The name of the resource group to deploy the pipeline into
resource_group_name = "<ADD_ME>"

# ID of the dedicated subnet to deploy the load balancer into
subnet_id_lb = "<SET_ME>"

# ID of the subnet to deploy the actual Iglu Server application into
subnet_id_servers = "<SET_ME>"

# Update this to _your_ IP Address
ssh_ip_allowlist = ["999.999.999.999/32"]
# Generate a new SSH key locally with `ssh-keygen`
# ssh-keygen -t rsa -b 4096 
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA0jSi9//bRsHW4M6czodTs6smCXsxZ0gijzth0aBmycE= snowplow@Snowplows-MacBook-Pro.local"

# Telemetry principles: https://docs.snowplowanalytics.com/docs/open-source-quick-start/what-is-the-quick-start-for-open-source/telemetry-principles/
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

