output "iam_group_name" {
  description = "Name of the created IAM group"
  value       = aws_iam_group.this.name
}

output "iam_policy_arn" {
  description = "ARN of the custom S3 write IAM policy"
  value       = aws_iam_policy.s3_write.arn
}

output "iam_role_arn" {
  description = "ARN of the IAM role assumable by EC2"
  value       = aws_iam_role.this.arn
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile associated with the role"
  value       = aws_iam_instance_profile.this.name
}