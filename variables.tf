variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "serverless-task-api"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for tasks"
  type        = string
  default     = "tasks"
}
