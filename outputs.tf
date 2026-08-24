output "users" {
  description = "contains all users related config"
  value       = azuread_user.this
}

output "user_passwords" {
  description = "contains all users passwords"
  value       = random_password.this
}
