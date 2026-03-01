output "backend_container_names" {
  value = module.backend.backend_container_names
}

output "load_balancer_url" {
  value = "http://localhost:8080"
}