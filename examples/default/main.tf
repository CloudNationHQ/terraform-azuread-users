data "azuread_domains" "this" {
  only_initial = true
}

module "users" {
  source  = "cloudnationhq/users/azuread"
  version = "~> 2.0"

  generate_password = true

  users = {
    user1 = {
      display_name          = "John Doe"
      given_name            = "John"
      surname               = "Doe"
      user_principal_name   = "john.doe@${data.azuread_domains.this.domains[0].domain_name}"
      city                  = "London"
      country               = "GB"
      department            = "Marketing"
      company_name          = "Contoso"
      force_password_change = true
    }
    user2 = {
      display_name          = "Jane Smith"
      given_name            = "Jane"
      surname               = "Smith"
      user_principal_name   = "jane.smith@${data.azuread_domains.this.domains[0].domain_name}"
      city                  = "Amsterdam"
      country               = "NL"
      department            = "Engineering"
      company_name          = "Contoso"
      force_password_change = true
    }
  }
}
