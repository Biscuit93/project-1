output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "azurerm_vlan_name" {
  value = azurerm_virtual_network.main.name
}

output "azurerm_nic_name" {
  value = azurerm_network_interface.main.name
}

output "azurerm_vm_name" {
  value = azurerm_virtual_machine.main.name
}

output "azurerm_sa_name" {
  value = azurerm_storage_account.main.name
}