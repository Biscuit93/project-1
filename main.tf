resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "azuread_user" "user1" {
  user_principal_name   = "anthony.ferski@fdmgroup.com"
  display_name          = "A. Ferski"
  mail_nickname         = var.admin_name
  password              = var.default_password
  force_password_change = "false"
}

resource "azuread_user" "user2" {
  user_principal_name   = "ibrahim.ozbekler@fdmgroup.com"
  display_name          = "I. Ozbekler"
  mail_nickname         = "iozbekler"
  password              = var.default_password
  force_password_change = "true"
}

resource "aws_iam_user" "classmates" {
  for_each = toset(var.users)
  name     = each.value
}

resource "aws_s3_bucket" "s3" {
  bucket = "bucket-${count.index}"
  count  = var.num_of_buckets
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.virtual_machine_name_prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    name = var.nametag
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.virtual_machine_name_prefix}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    name = var.nametag
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.virtual_machine_name_prefix}-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = var.osdiskname
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.hostname
    admin_username = var.admin_name
    admin_password = var.default_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.environment
    name        = var.nametag
  }
}

resource "azurerm_storage_account" "main" {
  name                = "${var.virtual_machine_name_prefix}-sa"
  resource_group_name = azurerm_resource_group.rg.name

  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.internal.id]
  }

  tags = {
    environment = var.environment
    name        = var.nametag
  }
}