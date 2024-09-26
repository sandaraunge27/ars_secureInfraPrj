output "bound_clain" {
    value = vault_jwt_auth_backend_role.jwt_role.bound_claims
    description = "vault JWT Auth Backend Role bound_clains"
}

output "role_name" {
    description = "vault JWT Auth Backend Role role name"
    value = vault_jwt_auth_backend_role.jwt_role.role_name 
}