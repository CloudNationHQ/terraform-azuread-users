resource "azuread_user" "main" {
  for_each = {
    for key, user in var.users : key => user
  }

  account_enabled             = coalesce(each.value.account_enabled, var.account_enabled)
  age_group                   = each.value.age_group
  business_phones             = each.value.business_phones
  company_name                = each.value.company_name
  consent_provided_for_minor  = each.value.consent_provided_for_minor
  cost_center                 = each.value.cost_center
  city                        = each.value.city
  country                     = each.value.country
  department                  = each.value.department
  disable_password_expiration = each.value.disable_password_expiration
  disable_strong_password     = each.value.disable_strong_password
  display_name                = each.value.display_name
  division                    = each.value.division
  employee_hire_date          = each.value.employee_hire_date
  employee_id                 = each.value.employee_id
  employee_type               = each.value.employee_type
  fax_number                  = each.value.fax_number
  force_password_change       = each.value.force_password_change
  given_name                  = each.value.given_name
  job_title                   = each.value.job_title
  mail                        = each.value.mail
  mail_nickname               = each.value.mail_nickname
  manager_id                  = each.value.manager_id
  mobile_phone                = each.value.mobile_phone
  office_location             = each.value.office_location
  onpremises_immutable_id     = each.value.onpremises_immutable_id
  other_mails                 = each.value.other_mails
  password                    = try(coalesce(each.value.password, random_password.user[each.key].result), null)
  postal_code                 = each.value.postal_code
  preferred_language          = each.value.preferred_language
  show_in_address_list        = each.value.show_in_address_list
  state                       = each.value.state
  street_address              = each.value.street_address
  surname                     = each.value.surname
  usage_location              = each.value.usage_location
  user_principal_name         = each.value.user_principal_name
}

resource "random_password" "user" {
  for_each = {
    for key, user in var.users : key => user if user.password == null && var.generate_password == true
  }

  length           = var.random_password.length
  special          = var.random_password.special
  override_special = var.random_password.override_special
  keepers          = var.random_password.keepers
  min_lower        = var.random_password.min_lower
  min_numeric      = var.random_password.min_numeric
  min_special      = var.random_password.min_special
  min_upper        = var.random_password.min_upper
  upper            = var.random_password.upper
  lower            = var.random_password.lower
  numeric          = var.random_password.numeric
}

resource "azurerm_key_vault_secret" "main" {
  for_each = {
    for key, user in var.users : key => user if user.password == null && var.generate_password == true
  }

  name = coalesce(
    each.value.key_vault_secret_name,
    try("${var.naming.key_vault_secret}-${replace(replace(each.value.display_name, " ", "-"), "_", "-")}", null),
    "kvs-password-${replace(replace(each.value.display_name, " ", "-"), "_", "-")}"
  )

  value           = random_password.user[each.key].result
  key_vault_id    = var.key_vault_id
  tags            = var.key_vault_secret.tags
  content_type    = var.key_vault_secret.content_type
  expiration_date = var.key_vault_secret.expiration_date
  not_before_date = var.key_vault_secret.not_before_date
}
