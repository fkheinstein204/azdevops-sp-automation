
locals {
  owners      = var.application_name
  environment = var.environment

  resource_name_prefix = "${var.application_name}-${var.environment}"

  block_name   = lower(replace("${var.environment}${random_string.main.result}", "-", ""))
  storage_name = "st${local.block_name}"

  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}