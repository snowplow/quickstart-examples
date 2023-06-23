# Quick start examples for Snowplow Deployment

[![Release][release-badge]][release]
[![License][license-image]][license]
[![Discourse posts][discourse-image]][discourse]

Examples of how to automate creating a [Snowplow Open Source pipeline](https://github.com/snowplow/snowplow).

These examples cover deploying an Iglu Server, for hosting your schemas, and a Snowplow pipeline.

## Supported Platforms

| Tool       | Cloud | Components              | Status                                      | Deployment Summary                           |
|------------|-------|-------------------------|---------------------------------------------|----------------------------------------------|
| Terraform  | AWS   | Iglu Server             | [Published](terraform/aws/iglu_server)      |                                              |
| Terraform  | AWS   | Pipeline (PostgreSQL)   | [Published](terraform/aws/pipeline)         | [AWS PostgreSQL Summary][deploypgsum-aws]    |
| Terraform  | AWS   | Pipeline (Snowflake)    | [Published](terraform/aws/pipeline)         | [AWS Snowflake Summary][deploysfsum-aws]     |
| Terraform  | AWS   | Pipeline (Redshift)     | [Published](terraform/aws/pipeline)         | [AWS Redshift Summary][deployrssum-aws]      |
| Terraform  | AWS   | Pipeline (Databricks)   | [Published](terraform/aws/pipeline)         | [AWS Databricks Summary][deploydbsum-aws]    |
| Terraform  | GCP   | Iglu Server             | [Published](terraform/gcp/iglu_server)      |                                              |
| Terraform  | GCP   | Pipeline (PostgreSQL)   | [Published](terraform/gcp/pipeline)         | [GCP PostgreSQL Summary][deploypgsum-gcp]    |
| Terraform  | GCP   | Pipeline (BigQuery)     | [Published](terraform/gcp/pipeline)         | [GCP BigQuery Summary][deploybqsum-gcp]      |
| Terraform  | Azure | Iglu Server             | [Published](terraform/azure/iglu_server)    |                                              |
| Terraform  | Azure | Pipeline (Snowflake)    | [Published](terraform/azure/pipeline)       | [Azure Snowflake Summary][deploysfsum-azure] |

## Documentation

| Installation Guide                     | FAQ                      |
|----------------------------------------|--------------------------|
| ![i1][install-image]                   |  ![i3][faq-image]        |
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
```

## Copyright and license

Copyright (c) 2022-present Snowplow Analytics Ltd. All rights reserved.

Licensed under the [Snowplow Community License](https://docs.snowplow.io/community-license-1.0). _(If you are uncertain how it applies to your use case, check our answers to [frequently asked questions](https://docs.snowplow.io/docs/contributing/community-license-faq/).)_

[install-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/techdocs.png
[deploy-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/setup.png
[faq-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/roadmap.png

[installguide]: https://docs.snowplow.io/docs/open-source-quick-start/
[faq]: https://docs.snowplow.io/docs/open-source-quick-start/quick-start-faqs/

[deploypgsum-aws]: https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/what-is-deployed/?warehouse=postgres&cloud=aws
[deploysfsum-aws]: https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/what-is-deployed/?warehouse=snowflake&cloud=aws
[deployrssum-aws]: https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/what-is-deployed/?warehouse=redshift&cloud=aws
[deploydbsum-aws]: https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/what-is-deployed/?warehouse=databricks&cloud=aws
[deploypgsum-gcp]: https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/what-is-deployed/?warehouse=postgres&cloud=gcp
[deploybqsum-gcp]: https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/what-is-deployed/?warehouse=bigquery&cloud=gcp
[deploysfsum-azure]: https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/what-is-deployed/?warehouse=snowflake&cloud=azure

[license]: https://docs.snowplow.io/docs/contributing/community-license-faq/
[license-image]: https://img.shields.io/badge/license-Snowplow--Community-blue.svg?style=flat

[discourse-image]: https://img.shields.io/discourse/posts?server=https%3A%2F%2Fdiscourse.snowplow.io%2F
[discourse]: http://discourse.snowplow.io/

[release]: https://github.com/snowplow/snowplow/releases
[release-badge]: https://img.shields.io/badge/Snowplow-22.01%20Western%20Ghats%20%28Patch.6%29-6638b8

[tf-docs]: https://github.com/terraform-docs/terraform-docs
