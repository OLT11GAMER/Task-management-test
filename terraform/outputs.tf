output "cluster_name" {
    value = google_container_container.default.name

}

output "cluster_endpoint" {
    value = google_container_container.default.endpoint

}

output "cluster_location" {
    value = google_container_container.default.location

}

output "load-balancer-ip" {
    value = google_container_container.default.address

}
