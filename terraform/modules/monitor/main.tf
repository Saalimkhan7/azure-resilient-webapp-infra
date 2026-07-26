resource "azurerm_log_analytics_workspace" "log" {
  name                = "log-webapp-demo"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    environment = "demo"
    project     = "azure-resilient-webapp"
  }
}

resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "alert-high-cpu"
  resource_group_name = var.resource_group_name
  scopes              = [var.vmss_id]
  description         = "Alert when average CPU exceeds 80% over 15 minutes"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  tags = {
    environment = "demo"
    project     = "azure-resilient-webapp"
  }
}