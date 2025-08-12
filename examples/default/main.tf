module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 4.0"

  vault = {
    name                = module.naming.key_vault.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
  }
}

module "users" {
  source  = "cloudnationhq/users/azuread"
  version = "~> 1.0"

  key_vault_id = module.kv.vault.id

  users = {
    user1 = {
      display_name        = "John Doe"
      given_name          = "John"
      surname             = "Doe"
      user_principal_name = "johndoe@cloudnationdev.com"
      city                = "London"
      country             = "GB"
      department          = "Marketing"
      company_name        = "Contoso"
      account_enabled     = false
      manager_id          = module.managers.users.manager1.object_id
    }
    user2 = {
      display_name          = "Jane Smith"
      given_name            = "Jane"
      surname               = "Smith"
      user_principal_name   = "janesmith@cloudnationdev.com"
      city                  = "Amsterdam"
      country               = "NL"
      department            = "Engineering"
      company_name          = "Organization"
      force_password_change = true
      manager_id            = module.managers.users.manager1.object_id
    }
  }

  depends_on = [module.kv]
}


module "managers" {
  source  = "cloudnationhq/users/azuread"
  version = "~> 1.0"

  key_vault_id = module.kv.vault.id

  users = {
    manager1 = {
      display_name          = "Alice Johnson"
      given_name            = "Alice"
      key_vault_secret_name = "alice-johnson-password"
      surname               = "Johnson"
      user_principal_name   = "alicejohnson@cloudnationdev.com"
      city                  = "Berlin"
      country               = "DE"
      department            = "Sales"
      company_name          = "Contoso"
    }
  }

  depends_on = [module.kv]
}
