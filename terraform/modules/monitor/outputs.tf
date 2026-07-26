output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log.id
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.log.name
}

output "cpu_alert_id" {
  value = azurerm_monitor_metric_alert.cpu_alert.id
}