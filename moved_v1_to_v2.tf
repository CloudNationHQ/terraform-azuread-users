moved {
  from = azuread_user.main
  to   = azuread_user.this
}

moved {
  from = random_password.user
  to   = random_password.this
}
