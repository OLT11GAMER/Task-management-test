resource "kubernetes_deployment" "name"{
    metadata{
        name = "tma-front"
        labels = {
            "type" = "frontend"
            "app" = "nodeapp"
        }
    }
    spec {
        replicas = 1
        selector{
            match_label = {
                "type" = "frontend"
                "app"  = "nodeapp"
            } 
        }
        template {
            metadata { 
                name = "tma-front"
                labels = {
                  "type" = "frontend"
                  "app"  = "nodeapp"
                }
            }
            spec{
                contaniner {
                    name = "tma-front-container"
                    image = var.container_image
                    port {
                        container_port = 80
                    }
                }
            }
        }
    }
}
resource "google-compute_address" "default"{ 
    name = "ipforservice"
    region = var.region

}
resource "kubernetes_service" "name" {
    metadata {
        name = "nodeapp-lb-service"
    
    }
    spec{
        type = "LoadBalancer"
        load_balancer_ip = google_computr_address.default.address
        port{
            port = 80
            target_port = 80
        }
        selector = {
            "type" = "frontend"
            "app"  = "nodeapp"
        }
    }
}