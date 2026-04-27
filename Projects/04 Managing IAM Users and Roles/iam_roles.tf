locals {
  roles_policies = {
    "admin" = [
      "AdministratorAccess"
    ],
    "readonly" = [
      "ReadOnlyAccess"
    ],
    "auditor" = [
      "SecurityAudit"
    ],
    "developer" = [
      "AmazonEC2FullAccess",
      "AmazonVPCFullAccess",
      "AmazonS3FullAccess",
      "AmazonRDSFullAccess"
    ]
  }

  role_policies_list = flatten([
    for role, policies in local.roles_policies : [
      for policy in policies : {
        role   = role
        policy = policy
      }
    ]
  ])
}

data "aws_iam_policy_document" "policy_document" {
  for_each = toset(
    keys(local.roles_policies)
  )
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        for user, roles in local.users :
        aws_iam_user.main[user].arn if contains(roles, each.key)
      ]
    }
  }


}

resource "aws_iam_role" "roles" {
  for_each = toset(keys(local.roles_policies))

  name = each.key
  assume_role_policy = jsonencode(
    data.aws_iam_policy_document.policy_document[each.key]
  )
}

data "aws_iam_policy" "policies" {
  for_each = toset(
    local.role_policies_list[*].policy
  )
  arn = "arn:aws:iam::aws:policy/${each.value}"
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  count = length(local.role_policies_list)

  role = aws_iam_role.roles[
    local.role_policies_list[count.index].role
  ].name

  policy_arn = data.aws_iam_policy.policies[
    local.role_policies_list[count.index].policy
  ].arn
}
