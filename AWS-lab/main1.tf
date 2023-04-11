provider "postgresql" {
  host = "localhost"
  port = 5432
  username = "postgres"
  database = "devx"
}

terraform {
  required_providers {
    postgresql = {
      source = "terraform-providers/postgresql"
      version = ">= 1.0"
    }
  }
}
module "users1" {
  source = ".//AWS-lab/users1.tff"
  providers = {
    postgresql = postgresql
  }
}

