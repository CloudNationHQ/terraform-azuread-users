variable "users" {
  description = "describes users related configuration"
  type = map(object({
    account_enabled             = optional(bool, true)
    age_group                   = optional(string) # allowed values are "Adult", "NotAdult", "Minor"
    business_phones             = optional(list(string))
    company_name                = optional(string)
    consent_provided_for_minor  = optional(string) # allowed values are "Granted", "Denied" and "NotRequired"
    cost_center                 = optional(string)
    city                        = optional(string)
    country                     = optional(string) # e.g. "US", "DE", "FR"
    department                  = optional(string)
    disable_password_expiration = optional(bool, false)
    disable_strong_password     = optional(bool, false)
    display_name                = string
    division                    = optional(string)
    employee_hire_date          = optional(string)
    employee_id                 = optional(string)
    employee_type               = optional(string)
    fax_number                  = optional(string)
    force_password_change       = optional(bool, true)
    given_name                  = optional(string)
    job_title                   = optional(string)
    key_vault_secret_name       = optional(string)
    mail                        = optional(string)
    mail_nickname               = optional(string)
    manager_id                  = optional(string)
    mobile_phone                = optional(string)
    office_location             = optional(string)
    onpremises_immutable_id     = optional(string)
    other_mails                 = optional(list(string), [])
    password                    = optional(string)
    postal_code                 = optional(string)
    preferred_language          = optional(string)
    show_in_address_list        = optional(bool, false)
    state                       = optional(string)
    street_address              = optional(string)
    surname                     = optional(string)
    usage_location              = optional(string)
    user_principal_name         = string
  }))
}

variable "account_enabled" {
  description = "default global flag whether user accounts should enabled or not"
  type        = bool
  default     = true
}

variable "key_vault_id" {
  description = "ID of the Key Vault where the password secrets for the user accounts will be stored"
  type        = string
  default     = null
  validation {
    condition     = var.generate_password == false || var.key_vault_id != null
    error_message = "key_vault_id must be provided when generate_password is set to true."
  }
}

variable "generate_password" {
  description = "Flag to indicate whether to generate a random password"
  type        = bool
  default     = true
}

variable "key_vault_secret" {
  description = "Properties of the Key Vault secret where the user passwords will be stored"
  type = object({
    content_type    = optional(string)
    expiration_date = optional(string)
    not_before_date = optional(string)
    tags            = optional(map(string))
  })
  default = {}
}

variable "random_password" {
  description = "Properties of the random password resource"
  type = object({
    length           = optional(number, 16)
    override_special = optional(string)
    special          = optional(bool)
    upper            = optional(bool)
    lower            = optional(bool)
    numeric          = optional(bool)
    min_lower        = optional(number, 3)
    min_upper        = optional(number, 3)
    min_special      = optional(number, 3)
    min_numeric      = optional(number, 3)
    keepers          = optional(map(string))
  })
  default = {}
}

variable "naming" {
  description = "contains naming convention"
  type = object({
    key_vault_secret = optional(string)
  })
  default = {}
}
