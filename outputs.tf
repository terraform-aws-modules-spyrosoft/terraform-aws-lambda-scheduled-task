output "lambda_name" {
  description = "Name of compute lambda"
  value       = module.scheduled_lambda.lambda_function_name
}

output "event_name" {
  description = "Name of event"
  value       = aws_cloudwatch_event_rule.scheduled_lambda_task.name
}

output "lambda_cron_schedule" {
  description = "Lambda execution schedule"
  value       = aws_cloudwatch_event_rule.scheduled_lambda_task.schedule_expression
}
