locals {
  lambda_role_policies = merge(
    var.lambda_role_policies != null ? var.lambda_role_policies : {},
    {
      "ScheduledTaskPolicyLog" = jsonencode({
        Version : "2012-10-17",
        Statement = [
          {
            Effect = "Allow",
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ],
            Resource = "*"
          }
        ]
      })
    }
  )
}

module "scheduled_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  description   = var.lambda_description
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout

  s3_existing_package = var.lambda_s3_existing_package
  publish             = var.lambda_publish

  tags                  = var.tags
  environment_variables = var.lambda_environment_variables

  lambda_role = aws_iam_role.scheduled_lambda_task.arn

  cloudwatch_logs_retention_in_days = var.lambda_cloudwatch_logs_retention_in_days
  cloudwatch_logs_tags              = var.tags

  # Modules resources
  create_package = false
  create_role    = false
}

resource "aws_cloudwatch_event_rule" "scheduled_lambda_task" {
  name                = var.scheduled_task_cloudwatch_event_name
  description         = var.scheduled_task_cloudwatch_event_description
  schedule_expression = var.scheduled_task_cloudwatch_event_expression
  is_enabled          = var.scheduled_task_cloudwatch_event_is_enabled
  tags                = var.tags
  depends_on          = [module.scheduled_lambda]
}

resource "aws_cloudwatch_event_target" "scheduled_lambda_task" {
  rule       = aws_cloudwatch_event_rule.scheduled_lambda_task.id
  arn        = module.scheduled_lambda.lambda_function_arn
  target_id  = module.scheduled_lambda.lambda_function_name
  depends_on = [module.scheduled_lambda]
}

resource "aws_iam_role" "scheduled_lambda_task" {
  name               = var.lambda_role_name
  assume_role_policy = var.lambda_assume_role_policy
  tags               = var.tags
}

resource "aws_iam_role_policy" "scheduled_task" {
  for_each = local.lambda_role_policies

  name   = each.key
  role   = aws_iam_role.scheduled_lambda_task.id
  policy = each.value
}

resource "aws_lambda_permission" "scheduled_task" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = module.scheduled_lambda.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.scheduled_lambda_task.arn
  depends_on    = [module.scheduled_lambda]
}
