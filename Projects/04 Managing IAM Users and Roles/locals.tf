locals {
  users = {
    for user in yamldecode(
      file("assets/user-roles.yaml")
    ).users : user.username => user.roles
  }

  roles = distinct(
    flatten([for key, value in local.users : value])
  )
}

output "users" {
  value = local.users
}