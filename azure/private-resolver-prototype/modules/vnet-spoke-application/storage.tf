resource "azurerm_storage_account" "storage-account" {
  name                     = "hhsstoragedemo"
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_table" "application-table" {
  name                 = "prototypetable"
  storage_account_name = azurerm_storage_account.storage-account.name
}

// setup a private endpoint for the storage account
/*resource "azurerm_private_endpoint" "example" {
  name                = "example-endpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id          = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "example-connection"
    is_manual_connection          = false
    private_connection_resource_id = azurerm_storage_account.storageacc.id
    subresource_names              = ["blob"]
  }
}
*/