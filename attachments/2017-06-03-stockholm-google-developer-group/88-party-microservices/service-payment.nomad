job "service-payment" {
  type = "service"
  datacenters = ["dc1"]

  group "Microservices" {
    count = "1"
    
    task "service-payment" {
      driver = "docker"

      config {
        image = "microservice:1.0.0"
        port_map {
          http = 3000
        }
      }

      resources {
        memory = 128  # MB
        cpu    = 20   # MHz
        iops   = 0    # Weight

        network {
          mbits = 10  # Mbit
          port "http" {}
        }
      }

      service {
        name = "service-payment"
        tags = ["nomad", "service-payment", "1.0.0"]
        port = "http"

        check {
          name     = "alive"
          type     = "http"
          path     = "/health"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
