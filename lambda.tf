data "archive_file" "create_task" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/create_task"
  output_path = "${path.module}/lambda/create_task.zip"
}

data "archive_file" "get_tasks" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/get_tasks"
  output_path = "${path.module}/lambda/get_tasks.zip"
}

data "archive_file" "get_task" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/get_task"
  output_path = "${path.module}/lambda/get_task.zip"
}

data "archive_file" "update_task" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/update_task"
  output_path = "${path.module}/lambda/update_task.zip"
}

data "archive_file" "delete_task" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/delete_task"
  output_path = "${path.module}/lambda/delete_task.zip"
}

resource "aws_lambda_function" "create_task" {
  filename         = data.archive_file.create_task.output_path
  function_name    = "${var.project_name}-create-task"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.create_task.output_base64sha256
  runtime         = "python3.11"
  timeout         = 10

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.tasks.name
    }
  }
}

resource "aws_lambda_function" "get_tasks" {
  filename         = data.archive_file.get_tasks.output_path
  function_name    = "${var.project_name}-get-tasks"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.get_tasks.output_base64sha256
  runtime         = "python3.11"
  timeout         = 10

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.tasks.name
    }
  }
}

resource "aws_lambda_function" "get_task" {
  filename         = data.archive_file.get_task.output_path
  function_name    = "${var.project_name}-get-task"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.get_task.output_base64sha256
  runtime         = "python3.11"
  timeout         = 10

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.tasks.name
    }
  }
}

resource "aws_lambda_function" "update_task" {
  filename         = data.archive_file.update_task.output_path
  function_name    = "${var.project_name}-update-task"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.update_task.output_base64sha256
  runtime         = "python3.11"
  timeout         = 10

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.tasks.name
    }
  }
}

resource "aws_lambda_function" "delete_task" {
  filename         = data.archive_file.delete_task.output_path
  function_name    = "${var.project_name}-delete-task"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.delete_task.output_base64sha256
  runtime         = "python3.11"
  timeout         = 10

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.tasks.name
    }
  }
}

resource "aws_cloudwatch_log_group" "create_task" {
  name              = "/aws/lambda/${aws_lambda_function.create_task.function_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "get_tasks" {
  name              = "/aws/lambda/${aws_lambda_function.get_tasks.function_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "get_task" {
  name              = "/aws/lambda/${aws_lambda_function.get_task.function_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "update_task" {
  name              = "/aws/lambda/${aws_lambda_function.update_task.function_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "delete_task" {
  name              = "/aws/lambda/${aws_lambda_function.delete_task.function_name}"
  retention_in_days = 7
}
