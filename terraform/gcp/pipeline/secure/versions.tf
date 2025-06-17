terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3"
    }
  }
}
