
data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}


resource "random_string" "main" {
  length  = 4
  upper   = false
  special = false
}


resource "azurerm_resource_group" "main" {
  name     = "RG-${local.resource_name_prefix}"
  location = var.resource_group_location
}

resource "azuread_application" "app_registration" {
  display_name = "${var.application_name}-SPN${random_string.main.result} - ${var.environment}"
  owners       = [data.azuread_client_config.current.object_id]

  feature_tags {
    enterprise = true
    gallery    = false
  }

  depends_on = [azurerm_key_vault_access_policy.admin, azurerm_storage_account.storage]
}

resource "azuread_service_principal" "spn" {
  client_id = azuread_application.app_registration.client_id
  owners    = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "client_secret" {
  application_id = azuread_application.app_registration.id
  display_name   = "DevOps - ${var.environment}"
}

# Assign SPN permission
resource "azurerm_role_assignment" "spn_role" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.spn.object_id
}

resource "azurerm_role_assignment" "spn_role_storage" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.spn.object_id
}

