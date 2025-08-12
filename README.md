# Entra ID (AzureAD) Users

 This terraform module simplifies the creation and management of Entra ID Users and its attributes, all managed through code.

## Features

Capability to manage Entra ID users, and its attributes.

Includes support for generated passwords and store them as secrets to a key vault.

Utilization of terratest for robust validation.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (~> 3.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.7)

## Providers

The following providers are used by this module:

- <a name="provider_azuread"></a> [azuread](#provider\_azuread) (3.5.0)

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (4.39.0)

- <a name="provider_random"></a> [random](#provider\_random) (3.7.2)

## Resources

The following resources are used by this module:

- [azuread_user.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) (resource)
- [azurerm_key_vault_secret.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) (resource)
- [random_password.user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_users"></a> [users](#input\_users)

Description: describes users related configuration

Type:

```hcl
map(object({
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
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_account_enabled"></a> [account\_enabled](#input\_account\_enabled)

Description: default global flag whether user accounts should enabled or not

Type: `bool`

Default: `true`

### <a name="input_generate_password"></a> [generate\_password](#input\_generate\_password)

Description: Flag to indicate whether to generate a random password

Type: `bool`

Default: `true`

### <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id)

Description: ID of the Key Vault where the password secrets for the user accounts will be stored

Type: `string`

Default: `null`

### <a name="input_key_vault_secret"></a> [key\_vault\_secret](#input\_key\_vault\_secret)

Description: Properties of the Key Vault secret where the user passwords will be stored

Type:

```hcl
object({
    content_type    = optional(string)
    expiration_date = optional(string)
    not_before_date = optional(string)
    tags            = optional(map(string))
  })
```

Default: `{}`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: contains naming convention

Type:

```hcl
object({
    key_vault_secret = optional(string)
  })
```

Default: `{}`

### <a name="input_random_password"></a> [random\_password](#input\_random\_password)

Description: Properties of the random password resource

Type:

```hcl
object({
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
```

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_user_passwords"></a> [user\_passwords](#output\_user\_passwords)

Description: contains all users passwords

### <a name="output_users"></a> [users](#output\_users)

Description: contains all users related config
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

At this moment, the `azuread_user` resource does not support `wo_only` passwords for ephemeral passwords yet. 
https://github.com/hashicorp/terraform-provider-azuread/issues/1586


Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Authors

Module is maintained by [these awesome contributors](https://github.com/cloudnationhq/terraform-azuread-users/graphs/contributors).

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azuread-users/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azuread-users" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/graph/azuread-users-concept-overview)
- [Rest Api](https://learn.microsoft.com/en-us/graph/api/resources/users)