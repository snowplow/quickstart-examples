terraform {
  required_version = "~> 1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.44.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
}
