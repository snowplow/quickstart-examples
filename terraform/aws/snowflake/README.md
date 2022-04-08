A Terraform module for preparing Snowflake for loading Snowplow data. It uses [Snowflake Loader Setup](https://github.com/snowplow-devops/terraform-aws-snowflake-loader-setup) and [Snowflake Target](https://github.com/snowplow-devops/terraform-snowflake-target) modules to create necessary resources.

Its outputs should be used as input variables of `aws/pipeline`.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.45.0 |
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | 0.25.32 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.45.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_snowflake_loader_setup"></a> [snowflake\_loader\_setup](#module\_snowflake\_loader\_setup) | snowplow-devops/snowflake-loader-setup/aws | 0.1.0 |
| <a name="module_snowflake_target"></a> [snowflake\_target](#module\_snowflake\_target) | snowplow-devops/target/snowflake | 0.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.snowflakedb_load_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.snowflakedb_load_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.snowflake_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.snowflake_load_assume_role_policy_storage_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.snowflake_load_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket events will be loaded into | `string` | n/a | yes |
| <a name="input_snowflake_account"></a> [snowflake\_account](#input\_snowflake\_account) | Snowflake account to use | `string` | n/a | yes |
| <a name="input_snowflake_loader_password"></a> [snowflake\_loader\_password](#input\_snowflake\_loader\_password) | The password to use for the loader user | `string` | n/a | yes |
| <a name="input_snowflake_operator_user_role"></a> [snowflake\_operator\_user\_role](#input\_snowflake\_operator\_user\_role) | Snowflake user role to pass Snowflake TF provider | `string` | n/a | yes |
| <a name="input_snowflake_operator_username"></a> [snowflake\_operator\_username](#input\_snowflake\_operator\_username) | Snowflake username to pass Snowflake TF provider | `string` | n/a | yes |
| <a name="input_snowflake_private_key_path"></a> [snowflake\_private\_key\_path](#input\_snowflake\_private\_key\_path) | Private key for accessing Snowflake | `string` | n/a | yes |
| <a name="input_snowflake_region"></a> [snowflake\_region](#input\_snowflake\_region) | Region of Snowflake account | `string` | n/a | yes |
| <a name="input_iam_permissions_boundary"></a> [iam\_permissions\_boundary](#input\_iam\_permissions\_boundary) | The permissions boundary ARN to set on IAM roles created | `string` | `""` | no |
| <a name="input_is_create_database"></a> [is\_create\_database](#input\_is\_create\_database) | Should database be created. Set to false, to use an existing one | `bool` | `true` | no |
| <a name="input_override_iam_loader_role_name"></a> [override\_iam\_loader\_role\_name](#input\_override\_iam\_loader\_role\_name) | Override transformed stage url, if not set it will be var.name with -snowflakedb-load-role suffix | `string` | `""` | no |
| <a name="input_override_snowflake_db_name"></a> [override\_snowflake\_db\_name](#input\_override\_snowflake\_db\_name) | Override database name. If not set it will be defaulted to uppercase var.name with "\_DATABASE" suffix | `string` | `""` | no |
| <a name="input_override_snowflake_loader_role"></a> [override\_snowflake\_loader\_role](#input\_override\_snowflake\_loader\_role) | Override loader role name in snowflake, if not set it will be uppercase var.name with "\_LOADER\_ROLE" suffix | `string` | `""` | no |
| <a name="input_override_snowflake_loader_user"></a> [override\_snowflake\_loader\_user](#input\_override\_snowflake\_loader\_user) | Override loader user name in snowflake, if not set it will be uppercase var.name with \_LOADER\_USER suffix | `string` | `""` | no |
| <a name="input_override_snowflake_schema"></a> [override\_snowflake\_schema](#input\_override\_snowflake\_schema) | Override snowflake schema | `string` | `"ATOMIC"` | no |
| <a name="input_override_snowflake_wh_name"></a> [override\_snowflake\_wh\_name](#input\_override\_snowflake\_wh\_name) | Override warehouse name, if not set it will be defaulted to uppercase var.name with "\_WAREHOUSE" suffix | `string` | `""` | no |
| <a name="input_s3_bucket_object_prefix"></a> [s3\_bucket\_object\_prefix](#input\_s3\_bucket\_object\_prefix) | An optional prefix under which Snowplow data will be saved (Note: your prefix must end with a trailing '/') | `string` | `""` | no |
| <a name="input_snowflake_file_format_name"></a> [snowflake\_file\_format\_name](#input\_snowflake\_file\_format\_name) | Name of the Snowflake file format which is used by stage | `string` | `"SNOWPLOW_ENRICHED_JSON"` | no |
| <a name="input_snowflake_wh_auto_resume"></a> [snowflake\_wh\_auto\_resume](#input\_snowflake\_wh\_auto\_resume) | Whether to enable auto resume which makes automatically resume the warehouse when any statement that requires a warehouse is submitted | `bool` | `true` | no |
| <a name="input_snowflake_wh_auto_suspend"></a> [snowflake\_wh\_auto\_suspend](#input\_snowflake\_wh\_auto\_suspend) | Time period to wait before suspending warehouse | `number` | `60` | no |
| <a name="input_snowflake_wh_size"></a> [snowflake\_wh\_size](#input\_snowflake\_wh\_size) | Size of the Snowflake warehouse to connect to | `string` | `"XSMALL"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to append to the resources in this module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_snowflake_database"></a> [snowflake\_database](#output\_snowflake\_database) | Snowflake database name |
| <a name="output_snowflake_loader_role"></a> [snowflake\_loader\_role](#output\_snowflake\_loader\_role) | Snowflake role for loading snowplow data |
| <a name="output_snowflake_loader_user"></a> [snowflake\_loader\_user](#output\_snowflake\_loader\_user) | The Snowflake user used by Snowflake Loader |
| <a name="output_snowflake_schema"></a> [snowflake\_schema](#output\_snowflake\_schema) | Snowflake schema name |
| <a name="output_snowflake_transformed_stage_name"></a> [snowflake\_transformed\_stage\_name](#output\_snowflake\_transformed\_stage\_name) | Name of transformed stage |
| <a name="output_snowflake_warehouse"></a> [snowflake\_warehouse](#output\_snowflake\_warehouse) | Snowflake warehouse name |