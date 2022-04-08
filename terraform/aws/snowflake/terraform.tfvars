# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "sp"

# --- S3
s3_bucket_name = "snowplow-terraform-sample-bucket-1"

# To save objects in a particular sub-directory you can pass in an optional prefix (e.g. 'foo/' )
s3_bucket_object_prefix = ""

# --- Snowplow Snowflake Loader
snowflake_account = "sf_account"
snowflake_region = "us-west-2"
snowflake_operator_username = "sf_operator"
snowflake_operator_user_role = "sf_role"
snowflake_private_key_path = "/path/to/private/key"
# Change and keep this secret!
snowflake_loader_password = "Hell0W0rld!2"

# --- AWS IAM (advanced setting)
iam_permissions_boundary = "" # e.g. "arn:aws:iam::0000000000:policy/MyAccountBoundary"

# --- Extra Tags to append to created resources (optional)
tags = {}
