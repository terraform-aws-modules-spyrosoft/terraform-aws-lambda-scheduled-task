# Lambda Function
output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.scheduled_lambda.lambda_function_arn
}

output "lambda_name" {
  description = "Lambda name"
  value       = module.scheduled_lambda.lambda_function_name
}

# IAM Role
output "lambda_role_arn" {
  description = "The ARN of the IAM role created for the Lambda Function"
  value       = module.scheduled_lambda.lambda_role_arn
}

# CloudWatch Log Group
output "lambda_cloudwatch_log_group_arn" {
  description = "The ARN of the Cloudwatch Log Group"
  value       = module.scheduled_lambda.lambda_cloudwatch_log_group_arn
}

output "lambda_cloudwatch_log_group_name" {
  description = "The name of the Cloudwatch Log Group"
  value       = module.scheduled_lambda.lambda_cloudwatch_log_group_name
}

# EventBridge
output "event_name" {
  description = "The name of the event"
  value       = aws_cloudwatch_event_rule.scheduled_lambda_task.name
}

output "lambda_cron_schedule" {
  description = "Lambda execution schedule"
  value       = aws_cloudwatch_event_rule.scheduled_lambda_task.schedule_expression
}
