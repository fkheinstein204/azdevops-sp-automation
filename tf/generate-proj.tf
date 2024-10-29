/*


resource "local_file" "main" {
  content  = ""
  filename = "${path.module}/../Production/main.tf"
}

resource "local_file" "providers" {
  content  = <<EOT

 terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.7.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.2"
    }
  }

 backend "azurerm" {
    subscription_id      = "${var.subscription_id}"
    resource_group_name  = "${azurerm_resource_group.main.name}"
    storage_account_name = "${azurerm_storage_account.storage.name}"
    container_name       = "${azurerm_storage_container.container.name}"
    key                  = "${var.application_name}-${var.environment}.tfstate"
  }
}


provider "azurerm" {
  features {}

  client_id       = var.spn_client_id
  client_secret   = var.spn_client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

  EOT
  filename = "${path.module}/../Production/providers.tf"
}


resource "local_file" "variables" {
  content  = <<EOT
variable "spn_client_id" { type = string }
variable "spn_client_secret" { type = string }
variable "tenant_id" { type = string }
variable "subscription_id" { type = string }
  EOT
  filename = "${path.module}/../Production/variables.tf"
}

resource "local_file" "tfvars" {
  content  = <<EOT
spn_client_id = "${azuread_service_principal.spn.client_id}"
spn_client_secret = "${azuread_application_password.client_secret.value}"
tenant_id = "${var.tenant_id}"
subscription_id = "${var.subscription_id}"
  EOT
  filename = "${path.module}/../Production/terraform.tfvars"
}

*/