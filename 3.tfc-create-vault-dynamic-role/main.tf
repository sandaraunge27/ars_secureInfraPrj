resource "vault_aws_secret_backend" "aws" {
  description = "Vault AWS Secret Engine Resource for AWS Master Account"
  access_key = data.terraform_remote_state.vault_admin.outputs.vault_admin_accesskey
  secret_key = data.terraform_remote_state.vault_admin.outputs.vault_admin_secret_accesskey
  region = var.aws_region
  path = var.secret_path.master_secret_path
  default_lease_ttl_seconds = 600
  max_lease_ttl_seconds = 1800
  lifecycle {
    ignore_changes = [
    access_key, secret_key
    ]
  }
}

resource "vault_aws_secret_backend_role" "iam_admin_dynamic_role" {
  backend = vault_aws_secret_backend.aws.path
  name = var.secret_role_name.master_iamadmin_role_name
  credential_type = var.credential_type.iam_user
  policy_arns = var.policy_arns_name.iamadmin
  
}


# resource "vault_aws_secret_backend_role" "network_admin_dynamic_role" {
#   backend = vault_aws_secret_backend.aws.path
#   name = var.secret_role_name.master_netadmin_role_name
#   credential_type = var.credential_type.iam_user
#   policy_arns = var.policy_arns_name.networkadmin
#   policy_document = <<EOT
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "iam:GetUser",
#       "Resource": "arn:aws:iam::339713018668:user/vault-token-terraform-*"
#     }
#   ]
# }
# EOT
# }

# resource "vault_aws_secret_backend_role" "ec2_admin_dynamic_role" {
#   backend = vault_aws_secret_backend.aws.path
#   name = var.secret_role_name.master_ec2admin_role_name
#   credential_type = var.credential_type.iam_user
#   policy_arns = var.policy_arns_name.ec2admin
#   policy_document = <<EOT
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "iam:GetUser",
#       "Resource": "arn:aws:iam::339713018668:user/vault-token-terraform-*"
#     }
#   ]
# }
# EOT
# }

# resource "vault_aws_secret_backend_role" "rds_admin_dynamic_role" {
#   backend = vault_aws_secret_backend.aws.path
#   name = var.secret_role_name.master_rdsadmin_role_name
#   credential_type = var.credential_type.iam_user
#   policy_arns = var.policy_arns_name.rdsadmin
#   policy_document = <<EOT
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "iam:GetUser",
#       "Resource": "arn:aws:iam::*:user/vault-token-terraform-*"
#     }
#   ]
# }
# EOT
# }