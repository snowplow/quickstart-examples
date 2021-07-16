# Quick start examples for Snowplow Deployment

[![License][license-image]][license]

Examples of how to automate creating a [Snowplow Open Source pipeline](https://github.com/snowplow/snowplow).

These examples cover deploying an Iglu Server, for hosting your schemas, and a Snowplow pipeline.

## Supported Platforms

| Tool       | Cloud | Components  | Status                                                      |
|------------|-------|-------------|-------------------------------------------------------------|
| Terraform  | AWS   | Iglu Server | [Published](terraform/aws/iglu_server)                      |
| Terraform  | AWS   | Pipeline    | [Published](terraform/aws/pipeline)                         |
| Terraform  | GCP   | Iglu Server | Coming Soon                                                 |
| Terraform  | GCP   | Pipeline    | Coming Soon                                                 |
|            |       |             |                                                             |

We hope to extend support to other infrastructure tooling in the future.

## Documentation

| Installation Guide                     | Deployment Summary                   | FAQ                     |
|----------------------------------------|--------------------------------------|-------------------------|
| ![i1][install-image]                   | ![i2][deploy-image]                  | ![i3][faq-image]        |
| **[Installation Guide][installguide]** | **[Deployment Summary][deploysum]**  | **[FAQ][faq]**          |

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
[deploysum]: https://docs.snowplowanalytics.com/docs/open-source-quick-start/quick-start-installation-guide-on-aws/summary-of-what-you-have-deployed/
[faq]: https://docs.snowplowanalytics.com/docs/open-source-quick-start/quick-start-faqs/

[license-image]: https://img.shields.io/badge/license-Apache--2-blue.svg?style=flat
[license]: https://www.apache.org/licenses/LICENSE-2.0
