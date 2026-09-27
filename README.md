# Quick start examples for Snowplow Deployment

[![Release][release-badge]][release]
[![License][license-image]][license]

Examples of how to automate creating a [self-hosted Snowplow pipeline](https://docs.snowplow.io/docs/get-started/self-hosted/).

These examples cover deploying an Iglu Server, for hosting your schemas, and a Snowplow pipeline.

## Supported Platforms

| Tool      | Cloud | Components                              | Status                                   | Deployment Summary                            |
|-----------|-------|-----------------------------------------|------------------------------------------|-----------------------------------------------|
| Terraform | AWS   | Iglu Server                             | [Published](terraform/aws/iglu_server)   |                                               |
| Terraform | AWS   | Pipeline (Snowflake)                    | [Published](terraform/aws/pipeline)      | [AWS Snowflake Summary][deploysfsum-aws]      |
| Terraform | AWS   | Pipeline (Redshift)                     | [Published](terraform/aws/pipeline)      | [AWS Redshift Summary][deployrssum-aws]       |
| Terraform | AWS   | Pipeline (Databricks)                   | [Published](terraform/aws/pipeline)      | [AWS Databricks Summary][deploydbsum-aws]     |
| Terraform | AWS   | Pipeline (S3)                           | [Published](terraform/aws/pipeline)      |                                               |
| Terraform | GCP   | Iglu Server                             | [Published](terraform/gcp/iglu_server)   |                                               |
| Terraform | GCP   | Pipeline (BigQuery)                     | [Published](terraform/gcp/pipeline)      | [GCP BigQuery Summary][deploybqsum-gcp]       |
| Terraform | Azure | Iglu Server                             | [Published](terraform/azure/iglu_server) |                                               |
| Terraform | Azure | Pipeline (Data Lake: Databricks)        | [Published](terraform/azure/pipeline)    | [Azure Databricks Summary][deploydbsum-azure] |
| Terraform | Azure | Pipeline (Data Lake: Synapse Analytics) | [Published](terraform/azure/pipeline)    | [Azure Synapse Summary][deploysasum-azure]    |

## Documentation

| Installation Guide                     | FAQ                      |
|----------------------------------------|--------------------------|
| **[Installation Guide][installguide]** |  **[FAQ][faq]**          |

### Updating READMEs

To generate the READMEs, use [terraform-docs][tf-docs].

For example:

```bash
terraform-docs -c .terraform-docs.yml terraform/aws/iglu_server/default
terraform-docs -c .terraform-docs.yml terraform/aws/iglu_server/secure
terraform-docs -c .terraform-docs.yml terraform/aws/pipeline/default
terraform-docs -c .terraform-docs.yml terraform/aws/pipeline/secure
terraform-docs -c .terraform-docs.yml terraform/gcp/iglu_server/default
terraform-docs -c .terraform-docs.yml terraform/gcp/iglu_server/secure
terraform-docs -c .terraform-docs.yml terraform/gcp/pipeline/default
terraform-docs -c .terraform-docs.yml terraform/gcp/pipeline/secure
terraform-docs -c .terraform-docs.yml terraform/azure/base
terraform-docs -c .terraform-docs.yml terraform/azure/iglu_server
terraform-docs -c .terraform-docs.yml terraform/azure/pipeline
```

## Copyright and license

Copyright (c) 2021-current Snowplow Analytics Ltd. All rights reserved.

Licensed under the [Snowplow Limited Use License Agreement][license]. _(If you are uncertain how it applies to your use case, check our answers to [frequently asked questions][license-faq].)_

[installguide]: https://docs.snowplow.io/docs/get-started/self-hosted/quick-start/
[faq]: https://docs.snowplow.io/docs/get-started/self-hosted/faq/

[deploysfsum-aws]: https://docs.snowplow.io/docs/get-started/self-hosted/what-is-deployed/?warehouse=snowflake&cloud=aws
[deployrssum-aws]: https://docs.snowplow.io/docs/get-started/self-hosted/what-is-deployed/?warehouse=redshift&cloud=aws
[deploydbsum-aws]: https://docs.snowplow.io/docs/get-started/self-hosted/what-is-deployed/?warehouse=databricks&cloud=aws
[deploybqsum-gcp]: https://docs.snowplow.io/docs/get-started/self-hosted/what-is-deployed/?warehouse=bigquery&cloud=gcp
[deploydbsum-azure]: https://docs.snowplow.io/docs/get-started/self-hosted/what-is-deployed/?warehouse=databricks&cloud=azure
[deploysasum-azure]: https://docs.snowplow.io/docs/get-started/self-hosted/what-is-deployed/?warehouse=synapse&cloud=azure

[license]: https://docs.snowplow.io/limited-use-license-1.1/
[license-image]: https://img.shields.io/badge/license-Snowplow--Limited--Use-blue.svg?style=flat
[license-faq]: https://docs.snowplow.io/docs/licensing/limited-use-license-faq/

[release]: https://github.com/snowplow/quickstart-examples/releases
[release-badge]: https://img.shields.io/badge/Snowplow-25.10-6638b8

[tf-docs]: https://github.com/terraform-docs/terraform-docs
