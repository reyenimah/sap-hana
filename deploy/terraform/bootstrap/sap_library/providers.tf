/*
Description:

  Constraining provider versions
    =    (or no operator): exact version equality
    !=   version not equal
    >    greater than version number
    >=   greater than or equal to version number
    <    less than version number
    <=   less than or equal to version number
    ~>   pessimistic constraint operator, constraining both the oldest and newest version allowed.
           For example, ~> 0.9   is equivalent to >= 0.9,   < 1.0 
                        ~> 0.8.4 is equivalent to >= 0.8.4, < 0.9
*/

provider "azurerm" {
  features {}
  
  subscription_id = var.use_spn ? local.spn.subscription_id : null
  client_id       = var.use_spn ? local.spn.client_id: null
  client_secret   = var.use_spn ? local.spn.client_secret: null
  tenant_id       = var.use_spn ? local.spn.tenant_id: null
}

provider "azurerm" {
  features {}
  alias = "deployer"
}

provider "azuread" {
  client_id     = local.spn.client_id
  client_secret = local.spn.client_secret
  tenant_id     = local.spn.tenant_id
}

terraform {
  required_version = ">= 0.13"
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.35.0"
    }
  }
}
