resource "aws_iam_user" "devops" {
  name = "devops"
}

resource "aws_iam_group" "engineers" {
  name = "engineers"
}

resource "aws_iam_group_membership" "devops_to_engineers" {
  name = "devops_to_engineers"
  group = aws_iam_group.engineers.name
  users = [aws_iam_user.devops.name]
}

resource "aws_iam_policy_attachment" "devops_permissions" {
  name       = "devops_permissions"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"

  # Attach the policy to the user
  users = [aws_iam_user.devops.name]

  # Attach the policy to the group
  groups = [aws_iam_group.engineers.name]
}
