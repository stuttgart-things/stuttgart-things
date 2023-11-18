resource "kubernetes_namespace" "nginx_app" {
  metadata {
    name = "nginx-app-${var.environment}"

    labels = {
      app = "nginx"
      env = var.environment
    }
  }
}

resource "kubernetes_deployment_v1" "nginx_app" {
  metadata {
    name      = "nginx-app"
    namespace = kubernetes_namespace.nginx_app.metadata.0.name

    labels = {
      app = "nginx"
      env = var.environment
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
        env = var.environment
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
          env = var.environment
        }
      }

      spec {
        container {
          image = "nginx:1.25.0"
          name  = "server"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "nginx" {
  metadata {
    name      = "nginx-app"
    namespace = kubernetes_namespace.nginx_app.metadata.0.name

    labels = {
      app = "nginx"
      env = var.environment
    }
  }

  spec {
    selector = {
      app = "nginx"
      env = var.environment
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "nginx" {
  metadata {
    name      = "nginx-app"
    namespace = kubernetes_namespace.nginx_app.metadata.0.name

    labels = {
      app = "nginx"
      env = var.environment
    }
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service_v1.nginx.metadata.0.name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

variable "environment" {
  type = string
}