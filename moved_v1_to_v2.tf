moved {
  from = azuread_user.main
  to   = azuread_user.this
}

moved {
  from = random_password.user
  to   = random_password.this
}

moved {
  from = azurerm_key_vault_secret.main
  to   = azurerm_key_vault_secret.this
}
