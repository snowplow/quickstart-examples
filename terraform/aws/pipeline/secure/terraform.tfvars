# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "sp"

# WARNING: You MUST change this as each bucket must be globally unique
s3_bucket_name = "snowplow-terraform-sample-bucket-1"

# To use an existing bucket set this to false and update the name above
s3_bucket_deploy = true

# To save objects in a particular sub-directory you can pass in an optional prefix (e.g. 'foo/')
s3_bucket_object_prefix = ""

# Update to the VPC you would like to deploy into which must have public & private subnet layers across which to deploy
# different layers of the application
vpc_id = "vpc-00000000"
# Load Balancer will be deployed in this layer
public_subnet_ids = ["subnet-00000000", "subnet-00000000"]
# EC2 Servers & RDS will be deployed in this layer
private_subnet_ids = ["subnet-00000000", "subnet-00000000"]

# Update this to the internal IP of your Bastion Host
ssh_ip_allowlist = ["999.999.999.999/32"]
# Generate a new SSH key locally with `ssh-keygen`
# ssh-keygen -t rsa -b 4096
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA0jSi9//bRsHW4M6czodTs6smCXsxZ0gijzth0aBmycE= snowplow@Snowplows-MacBook-Pro.local"

# Iglu Server DNS output from the Iglu Server stack
iglu_server_dns_name = "http://<CHANGE-TO-MY-IGLU-DNS-NAME>"
# Used for API actions on the Iglu Server
# Change this to the same UUID from when you created the Iglu Server
iglu_super_api_key = "00000000-0000-0000-0000-000000000000"

# Collector SSL Configuration (optional)
ssl_information = {
  certificate_arn = ""
  enabled         = false
}

# --- TARGETS CONFIGURATION ZONE --- #

# --- Target: Amazon S3
s3_raw_enabled      = false
s3_bad_enabled      = true
s3_enriched_enabled = true

# --- Target: PostgreSQL
postgres_db_enabled = false

postgres_db_name     = "snowplow"
postgres_db_username = "snowplow"
# Change and keep this secret!
postgres_db_password = "Hell0W0rld!2"
# IP ranges that you want to query the Pipeline Postgres RDS from
# Note: this exposes your data to the internet - take care to ensure your allowlist is strict enough
#       or provide a way to access the database through the VPC instead
postgres_db_ip_allowlist = ["999.999.999.999/32", "888.888.888.888/32"]

# --- Target: Snowflake
# Follow the guide to get input values for the loader:
# https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/quick-start-aws
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

# --- Target: Databricks
# Follow the guide to get input values for the loader:
# https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/quick-start-aws
databricks_enabled = false

databricks_catalog    = "hive_metastore"
databricks_schema     = "<SCHEMA>"
databricks_host       = "<HOST>"
databricks_port       = 443
databricks_http_path  = "<HTTP_PATH>"
databricks_auth_token = "<AUTH_TOKEN>"
# This controls how often data will be loading into Databricks
databricks_transformer_window_period_min = 1

# --- Target: Redshift
# Follow the guide to get input values for the loader:
# https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/quick-start-aws
redshift_enabled = false

redshift_host            = "<HOST>"
redshift_database        = "<DATABASE>"
redshift_port            = 5439
redshift_schema          = "<SCHEMA>"
redshift_loader_user     = "<LOADER_USER>"
redshift_loader_password = "<PASSWORD>"
# This controls how often data will be loading into Redshift
redshift_transformer_window_period_min = 1

# --- ADVANCED CONFIGURATION ZONE --- #

# Controls the write throughput of the KCL tables maintained by the various consumers deployed
pipeline_kcl_write_max_capacity = 50
# A boundary policy ARN (e.g. "arn:aws:iam::0000000000:policy/MyAccountBoundary")
iam_permissions_boundary = ""

# See for more information: https://registry.terraform.io/modules/snowplow-devops/collector-kinesis-ec2/aws/latest#telemetry
# Telemetry principles: https://docs.snowplowanalytics.com/docs/open-source-quick-start/what-is-the-quick-start-for-open-source/telemetry-principles/
user_provided_id  = ""
telemetry_enabled = true

# CloudWatch logging to ensure logs are saved outside of the server
cloudwatch_logs_enabled        = true
cloudwatch_logs_retention_days = 7

# Extra Tags to append to created resources (optional)
tags = {}
