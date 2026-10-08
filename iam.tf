# 1. IAM group
# Groups collect users so permissions can be managed together.
# NOTE: aws_iam_group does NOT support tags in the AWS API/provider,
# so the Project tag cannot be applied to it.
resource "aws_iam_group" "this" {
  name = local.group_name
}

# 2. Custom IAM policy
# templatefile() reads policy.json and replaces ${bucket_name} with the real value.
# path.module makes the file path work regardless of where terraform is run from.
resource "aws_iam_policy" "s3_write" {
  name = local.policy_name
  policy = templatefile("${path.module}/policy.json", {
    bucket_name = var.bucket_name
  })

  tags = local.tags
}

# 3. Trust policy document
# The trust (assume role) policy defines WHO can assume the role.
# Here it is the EC2 service, so instances can use the role.
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# 4. IAM role
# The role holds the permissions; the trust policy lets EC2 assume it.
resource "aws_iam_role" "this" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = local.tags
}

# 5. Attach the custom policy to the role
# This is what actually grants the S3 write permissions to the role.
resource "aws_iam_role_policy_attachment" "s3_write" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.s3_write.arn
}

# 6. Instance profile
# EC2 cannot use a role directly; it needs an instance profile wrapping the role.
resource "aws_iam_instance_profile" "this" {
  name = local.instance_profile_name
  role = aws_iam_role.this.name

  tags = local.tags
}