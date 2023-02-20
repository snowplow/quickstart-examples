# Quick start examples for Snowplow Deployment

[![Release][release-badge]][release]
[![License][license-image]][license]
[![Discourse posts][discourse-image]][discourse]

Examples of how to automate creating a [Snowplow Open Source pipeline](https://github.com/snowplow/snowplow).

These examples cover deploying an Iglu Server, for hosting your schemas, and a Snowplow pipeline.

## Supported Platforms

| Tool      | Cloud | Components            | Status                                 | Deployment Summary                        |
|-----------|-------|-----------------------|----------------------------------------|-------------------------------------------|
| Terraform | AWS   | Iglu Server           | [Published](terraform/aws/iglu_server) |                                           |
| Terraform | AWS   | Pipeline (PostgreSQL) | [Published](terraform/aws/pipeline)    | [AWS PostgreSQL Summary][deploypgsum-aws] |
| Terraform | AWS   | Pipeline (Snowflake)  | [Published](terraform/aws/snowflake)   | [AWS Snowflake Summary][deploysfsum-aws]  |
| Terraform | AWS   | Pipeline (Databricks) | [Published](terraform/aws/databricks)  | [AWS Databricks Summary][deploydbsum-aws] |
| Terraform | GCP   | Iglu Server           | [Published](terraform/gcp/iglu_server) |                                           |
| Terraform | GCP   | Pipeline (PostgreSQL) | [Published](terraform/gcp/pipeline)    | [GCP PostgreSQL Summary][deploysum-gcp]   |
| Terraform | GCP   | Pipeline (BigQuery)   | [Published](terraform/gcp/pipeline)    | [GCP BigQuery Summary][deploysum-gcp]     |

## Documentation

| Installation Guide                     | FAQ              |
|----------------------------------------|------------------|
| ![i1][install-image]                   | ![i3][faq-image] |
| **[Installation Guide][installguide]** | **[FAQ][faq]**   |

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

The Snowplow Quick start examples are copyright 2022 Snowplow Analytics Ltd.

Licensed under the **[Apache License, Version 2.0][license]** (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[install-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/techdocs.png
[deploy-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/setup.png
[faq-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/roadmap.png

[installguide]: https://docs.snowplow.io/docs/open-source-quick-start/
[faq]: https://docs.snowplow.io/docs/open-source-quick-start/quick-start-faqs/

[deploypgsum-aws]: https://docs.snowplow.io/docs/open-source-quick-start/quick-start-installation-guide-on-aws/summary-of-what-you-have-deployed/aws-and-postgres/
[deploysfsum-aws]: https://docs.snowplow.io/docs/open-source-quick-start/quick-start-installation-guide-on-aws/summary-of-what-you-have-deployed/aws-and-snowflake/
[deploydbsum-aws]: https://docs.snowplow.io/docs/open-source-quick-start/quick-start-installation-guide-on-aws/summary-of-what-you-have-deployed/aws-and-databricks/
[deploysum-gcp]: https://docs.snowplow.io/docs/open-source-quick-start/quick-start-installation-guide-on-gcp/summary-of-what-you-have-deployed/

[license-image]: https://img.shields.io/badge/license-Apache--2-blue.svg?style=flat
[license]: https://www.apache.org/licenses/LICENSE-2.0

[discourse-image]: https://img.shields.io/discourse/posts?server=https%3A%2F%2Fdiscourse.snowplow.io%2F
[discourse]: http://discourse.snowplow.io/

[release]: https://github.com/snowplow/snowplow/releases
[release-badge]: https://img.shields.io/badge/Snowplow-22.01%20Western%20Ghats%20%28Patch.4%29-6638b8

[tf-docs]: https://github.com/terraform-docs/terraform-docs
