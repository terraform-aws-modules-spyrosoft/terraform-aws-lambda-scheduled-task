variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(any)
  default     = {}
}

# Lambda variables

variable "lambda_name" {
  description = "A unique name of the Lambda Function"
  type        = string
  default     = null
}

variable "lambda_handler" {
  description = "Lambda Function entrypoint in your code"
  type        = string
  default     = null
}

variable "lambda_runtime" {
  description = "Lambda Function runtime. More info: https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html"
  type        = string
  default     = "python3.9"
}

variable "lambda_memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Valid value between 128 MB to 10,240 MB (10 GB), in 64 MB increments."
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 300
}

variable "lambda_environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "lambda_cloudwatch_logs_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Expected to be one of [0 1 3 5 7 14 30 60 90 120 150 180 365 400 545 731 1827 3653]"
  type        = number
  default     = null
}

# The role and policies of the Lambda

variable "lambda_role_name" {
  description = "Name of IAM role to use for Lambda Function"
  type        = string
  default     = null
}

variable "lambda_assume_role_policy" {
  description = "The assume policy for the IAM role for Lambda Function"
  type        = string
  default     = <<EOF
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
  description = "The inline policies added to IAM role for Lambda Function execution"
  type        = map(string)
  default     = {}
}

# The lambda deployment

variable "lambda_s3_existing_package" {
  description = "The S3 bucket object with keys bucket, key, version pointing to an existing zip-file to use"
  type        = map(string)
  default     = null
}

# Event variables

variable "scheduled_task_cloudwatch_event_name" {
  description = "The unique name of the EventBridge rule"
  type        = string
  default     = "scheduled_task_cloudwatch_event_name"
}

variable "scheduled_task_cloudwatch_event_description" {
  description = "Description of the EventBridge rule"
  type        = string
  default     = null
}

variable "scheduled_task_cloudwatch_event_expression" {
  description = "Time intervals for running the EventBridge rule. More info: https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-create-rule-schedule.html"
  type        = string
  default     = null
}
