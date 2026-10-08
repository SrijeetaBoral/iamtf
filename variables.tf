variable "region" {
  description = "AWS region where resources are created"
  type        = string
}

variable "project_id" {
  description = "Project identifier used as a prefix for resource names and as the Project tag value"
  type        = string
}

variable "bucket_name" {
  description = "Name of the pre-created S3 bucket the IAM policy grants write access to"
  type        = string
}