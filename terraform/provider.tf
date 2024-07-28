
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
provider "kubernetes"{
  host = google_container_cluster.default.endpoint
  token = data.google_client_config.current.access_token
  client_certifiate = base64code(google_container_cluster.default.master_auth[0].client_certificate)
  cleint_key = base64code(google_container_cluster.default.master_auth[0].client_key)
  cluster_ca_certificate = base64code(
    base64code(google_container_cluster.default.master_auth[0].cluster_ca_certificate)
  )
}