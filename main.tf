module "scheduled_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout

  s3_existing_package = var.lambda_s3_existing_package

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
  for_each = var.lambda_role_policies

  name   = each.key
  role   = aws_iam_role.scheduled_lambda_task.id
  policy = each.value
}