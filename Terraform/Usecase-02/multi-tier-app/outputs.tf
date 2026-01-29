output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_id" {
  value = module.networking.public_subnet_id
}

output "private_subnet_id" {
  value = module.networking.private_subnet_id
}

output "web_instance_id" {
  value = module.compute.web_instance_id
}

output "app_instance_id" {
  value = module.compute.app_instance_id
}

output "rds_endpoint" {
  value = module.database.rds_endpoint
}
