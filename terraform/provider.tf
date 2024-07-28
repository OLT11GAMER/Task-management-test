
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.38.0"
    }

    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
     kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.31.0"
    }
  }
}
provider "google" {
  credentials = "./gc_key.json"
  project     = "task-management-app-430719"
  region      = "europe-central2"
  zone        = "europe-central2-a"
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}