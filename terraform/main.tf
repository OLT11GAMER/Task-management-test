data "google_container_engine_versions" "default"{
  location = "europe-central2-a"
}
data "google_client_config" "current"{
}

resource "google_container_cluster" "default" {
  name               = "my-gke-cluster"
  location           = "eu-central2-a"
  remove_default_node_pool = true
  initial_node_count = 1
  min_master_version = data.google_container_engine_versions.default.latest_master_version
  network            = "default"

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 32
    # oauth_scopes = [
    #   "https://www.googleapis.com/auth/logging.write",
    #   "https://www.googleapis.com/auth/monitoring.write",
    #   "https://www.googleapis.com/auth/devstorage.read_only",
    #   "https://www.googleapis.com/auth/servicecontrol",
    #   "https://www.googleapis.com/auth/service.management.readonly",
    #   "https://www.googleapis.com/auth/trace.append",
    # ]

  }
  provisioner "local-exec"{
    when = destroy
    command = "sleep 90"
  }
}
# resource "google_compute_instance" "default" {
#   name         = "terraform-vm"
#   machine_type = "e2-medium"
#   zone         = "europe-central2-a"

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-2004-focal-v20210720"
#     }
#   }

#   network_interface {
#     network = "default"

#     access_config {
      
#     }
#   }

#   # metadata = {
#   #   ssh-keys = "username:${file(var.ssh_public_key_path)}"
#   # }
# }

resource "google_compute_firewall" "default" {
  name    = "default-allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# resource "docker_image" "mysql" {
#   name = "mysql:latest"
# }

# resource "docker_container" "mysql" {
#   image = docker_image.mysql.latest
#   name  = "mysql-container"

#   ports {
#     internal = 3306
#     external = 3306
#   }

#   env = [
#     "MYSQL_ROOT_PASSWORD=Admin123",
#     "MYSQL_DATABASE=tmadb",
#     "MYSQL_USER=amdin",
#     "MYSQL_PASSWORD=Admin123"
#   ]
# }


# resource "docker_image" "rabbitmq" {
#   name = "rabbitmq:latest"
# }

# resource "docker_container" "rabbitmq" {
#   image = docker_image.rabbitmq.latest
#   name  = "rabbitmq-container"

#   ports {
#     internal = 5672
#     external = 5672
#   }

#   ports {
#     internal = 15672
#     external = 15672
#   }
# }

# resource "google_container_cluster" "primary" {
#   name               = "my-gke-cluster"
#   location           = "eu-central1"
#   remove_default_node_pool = true
#   initial_node_count = 1
#   network            = "default"

#   node_config {
#     machine_type = "e2-medium"

#     oauth_scopes = [
#       "https://www.googleapis.com/auth/logging.write",
#       "https://www.googleapis.com/auth/monitoring.write",
#       "https://www.googleapis.com/auth/devstorage.read_only",
#       "https://www.googleapis.com/auth/servicecontrol",
#       "https://www.googleapis.com/auth/service.management.readonly",
#       "https://www.googleapis.com/auth/trace.append",
#     ]
#   }

#   master_authorized_networks_config {
#     cidr_blocks = [
#       {
#         cidr_block   = "0.0.0.0/0"
#         display_name = "public-access"
#       }
#     ]
#   }
# }

# resource "google_container_node_pool" "primary_nodes" {
#   cluster    = google_container_cluster.primary.name
#   location   = google_container_cluster.primary.location
#   node_count = 2

#   node_config {
#     machine_type = "e2-medium"

#     oauth_scopes = [
#       "https://www.googleapis.com/auth/logging.write",
#       "https://www.googleapis.com/auth/monitoring.write",
#       "https://www.googleapis.com/auth/devstorage.read_only",
#       "https://www.googleapis.com/auth/servicecontrol",
#       "https://www.googleapis.com/auth/service.management.readonly",
#       "https://www.googleapis.com/auth/trace.append",
#     ]
#   }
# }

