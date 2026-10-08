locals {
  group_name            = "${var.project_id}-iam-group"
  policy_name           = "${var.project_id}-iam-policy"
  role_name             = "${var.project_id}-iam-role"
  instance_profile_name = "${var.project_id}-iam-instance-profile"

  tags = {
    Project = var.project_id
  }
}