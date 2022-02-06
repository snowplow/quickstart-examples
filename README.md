# Quick start examples for Snowplow Deployment

[![Release][release-badge]][release]
[![License][license-image]][license]
[![Discourse posts][discourse-image]][discourse]

Examples of how to automate creating a [Snowplow Open Source pipeline](https://github.com/snowplow/snowplow).

These examples cover deploying an Iglu Server, for hosting your schemas, and a Snowplow pipeline.

## Supported Platforms

| Tool       | Cloud | Components  | Status                                      | Deployment Summary           |
|------------|-------|-------------|---------------------------------------------|------------------------------|
| Terraform  | AWS   | Iglu Server | [Published](terraform/aws/iglu_server)      |                              |
| Terraform  | AWS   | Pipeline    | [Published](terraform/aws/pipeline)         | [AWS Summary][deploysum-aws] |
| Terraform  | GCP   | Iglu Server | [Published](terraform/gcp/iglu_server)      |                              |
| Terraform  | GCP   | Pipeline    | [Published](terraform/gcp/pipeline)         | [GCP Summary][deploysum-gcp] |

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

The Snowplow Quick start examples are copyright 2021 Snowplow Analytics Ltd.

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

[installguide]: https://docs.snowplowanalytics.com/docs/open-source-quick-start/
[faq]: https://docs.snowplowanalytics.com/docs/open-source-quick-start/quick-start-faqs/

[deploysum-aws]: https://docs.snowplowanalytics.com/docs/open-source-quick-start/quick-start-installation-guide-on-aws/summary-of-what-you-have-deployed/
[deploysum-gcp]: https://docs.snowplowanalytics.com/docs/open-source-quick-start/quick-start-installation-guide-on-gcp/summary-of-what-you-have-deployed-gcp/

[license-image]: https://img.shields.io/badge/license-Apache--2-blue.svg?style=flat
[license]: https://www.apache.org/licenses/LICENSE-2.0

[discourse-image]: https://img.shields.io/discourse/posts?server=https%3A%2F%2Fdiscourse.snowplowanalytics.com%2F
[discourse]: http://discourse.snowplowanalytics.com/

[release]: https://github.com/snowplow/snowplow/releases
[release-badge]: https://img.shields.io/badge/Snowplow-21.08%20North%20Cascades%20%28Patch.2%29-6638b8

[tf-docs]: https://github.com/terraform-docs/terraform-docs
