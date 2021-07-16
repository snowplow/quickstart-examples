# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "sp"

# --- S3
s3_bucket_name = "snowplow-terraform-sample-bucket-1"

# To use an existing bucket set this to false
s3_bucket_deploy = true

# To save objects in a particular sub-directory you can pass in an optional prefix (e.g. 'foo/' )
s3_bucket_object_prefix = ""

# --- Default VPC
# Update to the VPC you would like to deploy into
# Find your default: https://docs.aws.amazon.com/vpc/latest/userguide/default-vpc.html#view-default-vpc
vpc_id            = "vpc-00000000"
public_subnet_ids = ["subnet-00000000", "subnet-00000001"]

# --- SSH
# Update this to your IP Address
ssh_ip_allowlist = ["999.999.999.999/32"]
# Generate a new SSH key locally with `ssh-keygen`
# ssh-keygen -t rsa -b 4096 
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA0jSi9//bRsHW4M6czodTs6smCXsxZ0gijzth0aBmycE= snowplow@Snowplows-MacBook-Pro.local"

# --- Iglu Server Configuration
# Iglu Server DNS output from the Iglu Server stack
iglu_server_dns_name = "http://CHANGE-TO-MY-IGLU-URL.elb.amazonaws.com"
# Used for API actions on the Iglu Server
# Change this to the same UUID from when you created the Iglu Server
iglu_super_api_key = "00000000-0000-0000-0000-000000000000"

# NOTE: Needed for Postgres Loader to work
# igluctl: https://docs.snowplowanalytics.com/docs/pipeline-components-and-applications/iglu/igluctl
# Ensure you have seeded Iglu Server: 
# git clone https://github.com/snowplow/iglu-central
# cd iglu-central
# igluctl static push --public schemas/ http://CHANGE-TO-MY-IGLU-URL.elb.amazonaws.com 00000000-0000-0000-0000-000000000000

# --- Snowplow Postgres Loader
pipeline_db_name     = "snowplow"
pipeline_db_username = "snowplow"
# Change and keep this secret!
pipeline_db_password = "Hell0W0rld!2"
# IP ranges that you want to query the Pipeline Postgres RDS from
# Note: this exposes your data to the internet - take care to ensure your allowlist is strict enough
#       or provide a way to access the database through the VPC instead
pipeline_db_publicly_accessible = true
pipeline_db_ip_allowlist        = ["999.999.999.999/32", "888.888.888.888/32"]

# Note: the postgres loader can be limited by KCL throughput - increasing this is crucial for anything over 50 RPS.
#       There is roughly a 1:1 relationship between this value and Rows per second (RPS).
#
# While this limit is most important to the Postgres Loader this write capacity will be applied to all consumers.
pipeline_kcl_write_max_capacity = 50

# See for more information: https://registry.terraform.io/modules/snowplow-devops/collector-kinesis-ec2/aws/latest#telemetry
# Telemetry principles: https://docs.snowplowanalytics.com/docs/open-source-quick-start/what-is-the-quick-start-for-open-source/telemetry-principles/
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
