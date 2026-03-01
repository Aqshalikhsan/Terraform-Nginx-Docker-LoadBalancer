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

resource "docker_container" "backend" {
  count = var.server_count
  name  = "backend_${count.index}"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = var.network_name
  }

  command = [
    "sh",
    "-c",
    "echo '<h1>Backend Server ${count.index}</h1>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
  ]
}

output "backend_container_names" {
  value = docker_container.backend[*].name
}