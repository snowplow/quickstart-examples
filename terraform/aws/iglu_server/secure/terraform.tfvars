# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "sp"

# --- VPC
# Update to the VPC you would like to deploy into which must have public & private subnet layers across which to deploy
# different layers of the application
vpc_id             = "vpc-00000000"
# Load Balancer will be deployed in this layer
public_subnet_ids  = ["subnet-00000000", "subnet-00000000"]
# EC2 Servers & RDS will be deployed in this layer
private_subnet_ids = ["subnet-00000000", "subnet-00000000"]

# --- SSH
# Update this to the internal IP of your Bastion Host
ssh_ip_allowlist = ["999.999.999.999/32"]
# Generate a new SSH key locally with `ssh-keygen`
# ssh-keygen -t rsa -b 4096 
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA0jSi9//bRsHW4M6czodTs6smCXsxZ0gijzth0aBmycE= snowplow@Snowplows-MacBook-Pro.local"

# --- Snowplow Iglu Server
iglu_db_name     = "iglu"
iglu_db_username = "iglu"
# Change and keep this secret!
iglu_db_password = "Hell0W0rld!"

# Used for API actions on the Iglu Server
# Change this to a new UUID and keep it secret!
iglu_super_api_key = "00000000-0000-0000-0000-000000000000"

# NOTE: Needed for Postgres Loader to work
# igluctl: https://docs.snowplowanalytics.com/docs/pipeline-components-and-applications/iglu/igluctl
# Ensure you have seeded Iglu Server: 
# git clone https://github.com/snowplow/iglu-central
# cd iglu-central
# igluctl static push --public schemas/ http://CHANGE-TO-MY-IGLU-URL.elb.amazonaws.com 00000000-0000-0000-0000-000000000000

# See for more information: https://github.com/snowplow-devops/terraform-aws-iglu-server-ec2#telemetry
# Telemtry policy: https://docs.snowplowanalytics.com/docs/telemetry-policy/
user_provided_id  = ""
telemetry_enabled = true

# --- AWS IAM (advanced setting)
iam_permissions_boundary = "" # e.g. "arn:aws:iam::0000000000:policy/MyAccountBoundary"

# --- SSL Configuration (optional)
ssl_information = {
  certificate_arn = ""
  enabled         = false
}

# --- Extra Tags to append to created resources (optional)
tags = {}
