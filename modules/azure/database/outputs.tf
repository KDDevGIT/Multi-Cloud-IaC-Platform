output "sql_server_id" {
  description = "Azure SQL Server ID"
  value = azurerm_mssql_server.this.id 
}

output "sql_server_fqdn" {
  description = "Fully Qualified Domain Name of the Azure SQL Server"
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "dabase_id" {
  description = "Azure SQL Database ID"
  value = azurerm_mssql_database.this.id 
}