## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.45.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.45.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iglu_lb"></a> [iglu\_lb](#module\_iglu\_lb) | snowplow-devops/alb/aws | 0.1.2 |
| <a name="module_iglu_rds"></a> [iglu\_rds](#module\_iglu\_rds) | snowplow-devops/rds/aws | 0.1.4 |
| <a name="module_iglu_server"></a> [iglu\_server](#module\_iglu\_server) | snowplow-devops/iglu-server-ec2/aws | 0.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iglu_db_name"></a> [iglu\_db\_name](#input\_iglu\_db\_name) | The name of the database to create | `string` | n/a | yes |
| <a name="input_iglu_db_password"></a> [iglu\_db\_password](#input\_iglu\_db\_password) | The password to use to connect to the database | `string` | n/a | yes |
| <a name="input_iglu_db_username"></a> [iglu\_db\_username](#input\_iglu\_db\_username) | The username to use to connect to the database | `string` | n/a | yes |
| <a name="input_iglu_super_api_key"></a> [iglu\_super\_api\_key](#input\_iglu\_super\_api\_key) | A UUIDv4 string to use as the master API key for Iglu Server management | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | The list of public subnets to deploy the components across | `list(string)` | n/a | yes |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The list of CIDR ranges to allow SSH traffic from | `list(any)` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH public key to use for the deployment | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC to deploy the components within | `string` | n/a | yes |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input\_cloudwatch\_logs\_enabled) | Whether application logs should be reported to CloudWatch | `bool` | `true` | no |
| <a name="input_cloudwatch_logs_retention_days"></a> [cloudwatch\_logs\_retention\_days](#input\_cloudwatch\_logs\_retention\_days) | The length of time in days to retain logs for | `number` | `7` | no |
| <a name="input_iam_permissions_boundary"></a> [iam\_permissions\_boundary](#input\_iam\_permissions\_boundary) | The permissions boundary ARN to set on IAM roles created | `string` | `""` | no |
| <a name="input_ssl_information"></a> [ssl\_information](#input\_ssl\_information) | The ARN of an Amazon Certificate Manager certificate to bind to the load balancer | <pre>object({<br>    enabled         = bool<br>    certificate_arn = string<br>  })</pre> | <pre>{<br>  "certificate_arn": "",<br>  "enabled": false<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to append to the resources in this module | `map(string)` | `{}` | no |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iglu_server_dns_name"></a> [iglu\_server\_dns\_name](#output\_iglu\_server\_dns\_name) | The ALB dns name for the Iglu Server |