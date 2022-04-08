terraform {
  required_version = "~> 1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.45.0"
    }
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "~> 0.25.32"
    }
  }
}
