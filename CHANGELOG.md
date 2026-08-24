# Changelog

## [2.0.0](https://github.com/CloudNationHQ/terraform-azuread-users/compare/v1.0.0...v2.0.0) (2026-08-24)


### ⚠ BREAKING CHANGES

* remove key vault secret resource
* generate_password no longer has a default value and must be set explicitly by the caller. Existing callers that relied on the implicit default of true must now set generate_password = true explicitly.
* upgrade to azurerm v5 and align with cn module standards

### Features

* move force_password_change default into a top-level variable ([eab454d](https://github.com/CloudNationHQ/terraform-azuread-users/commit/eab454d77f83e272a549cc4e6efd59ef2fc9d3e6))
* remove key vault secret resource ([d79521a](https://github.com/CloudNationHQ/terraform-azuread-users/commit/d79521a378fef6168074b8d0a51fc9432a6811d0))
* simplify default example, decouple password generation from key vault ([2ab4a83](https://github.com/CloudNationHQ/terraform-azuread-users/commit/2ab4a831f6316437a486f4b1b804da16af5936cf))
* upgrade to azurerm v5 and align with cn module standards ([bc16ab3](https://github.com/CloudNationHQ/terraform-azuread-users/commit/bc16ab3120d5c535c8614b1579281598a88ba497))

## 1.0.0 (2025-08-12)


### Features

* add initial resources ([fb115a6](https://github.com/CloudNationHQ/terraform-azuread-users/commit/fb115a69c5d2f438e099dd3fab2ec647f3406aec))
* add initial resources ([be0c9bd](https://github.com/CloudNationHQ/terraform-azuread-users/commit/be0c9bd26d1abaeee6aa8e41cd2b716b17ee32cd))

## Changelog
