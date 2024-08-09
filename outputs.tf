output "resource_group_name" {
  value = module.resource_group.name
}

output "virtual_network_name" {
  value = module.virtual_network.name
}

output "web_subnet_id" {
  value = module.web_subnet.id
}

output "db_subnet_id" {
  value = module.db_subnet.id
}

output "web_nsg_id" {
  value = module.web_nsg.id
}

output "db_nsg_id" {
  value = module.db_nsg.id
}

output "web_vm_ids" {
  value = module.web_vms.vm_id
}

output "db_vm_id" {
  value = module.db_vm.vm_id
}

output "load_balancer_public_ip" {
  value = module.load_balancer.lb_public_ip
}

output "application_gateway_public_ip" {
  value = module.application_gateway.app_gateway_public_ip
}

output "sql_server_name" {
  value = module.sql_database.sql_server_name
}

output "sql_db_name" {
  value = module.sql_database.sql_db_name
}

output "backup_vault_id" {
  value = module.backup.vault_id
}

output "key_vault_id" {
  value = module.key_vault.key_vault_id
}

output "vault_id" {
  value = module.backup.vault_id
}