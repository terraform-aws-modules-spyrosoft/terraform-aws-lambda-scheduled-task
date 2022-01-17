# Scheduled lambda task

A Terraform module that creates a lambda for a scheduled task

The lambda code must be zipped and sent to the S3 bucket.

## Usage

### A scheduled task

The most common use-case that creates the sample lambda is executed every 5 minutes.

```hcl
module "scheduled_task" {
  source = "terraform-aws-modules-spyrosoft/lambda-scheduled-task/aws"

  lambda_name        = "scheduled_lambda"
  lambda_handler     = "lambda_function.lambda_handler"
  lambda_runtime     = "python3.9"
  lambda_memory_size = 128
  lambda_timeout     = 30

  lambda_s3_existing_package = {
    bucket = "scheduled-lambda-bucket"
    key    = "scheduled_lambda_example.zip"
  }

  lambda_role_name                         = "ScheduledTaskExample"
  lambda_cloudwatch_logs_retention_in_days = 14

  scheduled_task_cloudwatch_event_name       = "ScheduledLambdaExample"
  scheduled_task_cloudwatch_event_expression = "rate(5 minutes)"
}
```
