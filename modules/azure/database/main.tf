resource "azurerm_mssql_server" "this" {
  name                         = "${replace(var.name, "-", "")}sqlsrv"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.db_admin_username
  administrator_login_password = var.db_admin_password

  tags = {
    Name = "${var.name}-sql-server"
  }
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "allow-azure-services"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_database" "this" {
  name      = var.db_name
  server_id = azurerm_mssql_server.this.id
  sku_name  = var.sku_name

  tags = {
    Name = "${var.name}-sql-db"
  }
}