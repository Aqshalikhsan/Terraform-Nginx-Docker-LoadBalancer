terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "loadbalancer" {
  name  = "nginx_lb"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = var.network_name
  }

  volumes {
    host_path      = abspath("${path.root}/lb/nginx.conf")
    container_path = "/etc/nginx/nginx.conf"
  }

  ports {
    internal = 80
    external = 8080
  }
}