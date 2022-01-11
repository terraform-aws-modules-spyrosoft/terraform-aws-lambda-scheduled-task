variable "tags" {
  type    = map(any)
  default = {}
}

# Lambda variables

variable "lambda_name" {
  type    = string
  default = null
}

variable "lambda_handler" {
  type    = string
  default = null
}

variable "lambda_runtime" {
  type    = string
  default = "python3.9"
}

variable "lambda_memory_size" {
  type    = number
  default = 128
}

variable "lambda_timeout" {
  type    = number
  default = 300
}

variable "lambda_environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "lambda_cloudwatch_logs_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group."
  type        = number
  default     = null
}

# The role and policies of the Lambda

variable "lambda_role_name" {
  type    = string
  default = null
}

variable "lambda_assume_role_policy" {
  type    = string
  default = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sts:AssumeRole"
      ],
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      }
    }
  ]
}
EOF
}

variable "lambda_role_policies" {
  type    = map(string)
  default = null
}

# The lambda deployment

variable "lambda_s3_existing_package" {
  description = "The S3 bucket object with keys bucket, key, version pointing to an existing zip-file to use"
  type        = map(string)
  default     = null
}

# Event variables

variable "scheduled_task_cloudwatch_event_name" {
  type    = string
  default = "scheduled_task_cloudwatch_event_name"
}

variable "scheduled_task_cloudwatch_event_description" {
  type    = string
  default = null
}

variable "scheduled_task_cloudwatch_event_expression" {
  type    = string
  default = null
}
