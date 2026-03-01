terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_network" "app_network" {
  name = "mini_network"
}

module "backend" {
  source       = "./modules/backend"
  network_name = docker_network.app_network.name
  server_count = var.server_count
}

module "loadbalancer" {
  source       = "./modules/loadbalancer"
  network_name = docker_network.app_network.name
}