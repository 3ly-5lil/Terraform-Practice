resource "aws_iam_user" "main" {
  for_each = local.users

  name = each.key

}

resource "aws_iam_user_login_profile" "main" {
  for_each = aws_iam_user.main

  user = each.value.name

  lifecycle {
    ignore_changes = [
      pgp_key,
      password_length,
      password_reset_required,
    ]
  }
}

# output "users" {
#   value = [
#     for user in aws_iam_user.main :
#       user.name
# 	]
# }

# output "passwords" {
#   value = {
#     for user, profile in aws_iam_user_login_profile.main :
# 		user => profile.password
#   }
# 	sensitive = true
# }
