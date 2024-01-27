#trivy:ignore:AVD-AWS-0135
resource "aws_sqs_queue" "SQS-Shopify" {
  kms_master_key_id = "alias/aws/sqs"
  name              = "SQS-Shopify"
}

data "archive_file" "sqs_handler" {
  output_path = "${path.module}/sqs.zip"
  type        = "zip"

  source {
    content  = "exports.handler = async function(event, context) { event.Records.forEach(record => { const { body } = record; console.log(body);  }); return {}; }"
    filename = "index.js"
  }
}

module "lambda" {
  source = "../../.."

  description      = "Example usage for an AWS Lambda with a SQS event source mapping"
  filename         = data.archive_file.sqs_handler.output_path
  function_name    = "Shopify_Lambda"
  handler          = "index.handler"
  runtime          = "java17"
  source_code_hash = data.archive_file.sqs_handler.output_base64sha256

  event_source_mappings = {
    SQS-Shopify = {
      event_source_arn = aws_sqs_queue.SQS-Shopify.arn

      // optionally overwrite function_name in case an alias should be used in the
      // event source mapping, see https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html
      // function_name    = aws_lambda_alias.example.arn

      // optionally overwrite arguments from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping
      batch_size = 5

      scaling_config = {
        maximum_concurrency = 2
      }

      // Lambda event filtering, see https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventfiltering.html
      filter_criteria = [
        {
          pattern = jsonencode({
            body : {
              Key1 : ["Value1"]
            }
          })
        },
        {
        }
      ]
    }
    SQS-Shopify = {
      event_source_arn = aws_sqs_queue.SQS-Shopify.arn
    }
  }
}



resource "aws_sqs_queue" "SendGrid" {
  kms_master_key_id = "alias/aws/sqs"
  name              = "SendGrid"
}

data "archive_file" "sqs_handler1" {
  output_path = "${path.module}/sqs.zip"
  type        = "zip"

  source {
    content  = "exports.handler = async function(event, context) { event.Records.forEach(record => { const { body } = record; console.log(body);  }); return {}; }"
    filename = "index.js"
  }
}

module "lambda1" {
  source = "../../.."

  description      = "Example usage for an AWS Lambda with a SQS event source mapping"
  filename         = data.archive_file.sqs_handler.output_path
  function_name    = "SendGrid_Lambda"
  handler          = "index.handler"
  runtime          = "java17"
  source_code_hash = data.archive_file.sqs_handler.output_base64sha256

  event_source_mappings = {
    SendGrid = {
      event_source_arn = aws_sqs_queue.SendGrid.arn

      // optionally overwrite function_name in case an alias should be used in the
      // event source mapping, see https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html
      // function_name    = aws_lambda_alias.example.arn

      // optionally overwrite arguments from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping
      batch_size = 5

      scaling_config = {
        maximum_concurrency = 2
      }

      // Lambda event filtering, see https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventfiltering.html
      filter_criteria = [
        {
          pattern = jsonencode({
            body : {
              Key1 : ["Value1"]
            }
          })
        },
        {
        }
      ]
    }
    SendGrid = {
      event_source_arn = aws_sqs_queue.SendGrid.arn
    }
  }
}



resource "aws_sqs_queue" "HubSpot" {
  kms_master_key_id = "alias/aws/sqs"
  name              = "HubSpot"
}

data "archive_file" "sqs_handler2" {
  output_path = "${path.module}/sqs.zip"
  type        = "zip"

  source {
    content  = "exports.handler = async function(event, context) { event.Records.forEach(record => { const { body } = record; console.log(body);  }); return {}; }"
    filename = "index.js"
  }
}

module "lambda2" {
  source = "../../.."

  description      = "Example usage for an AWS Lambda with a SQS event source mapping"
  filename         = data.archive_file.sqs_handler.output_path
  function_name    = "HubSpot_Lambda"
  handler          = "index.handler"
  runtime          = "java17"
  source_code_hash = data.archive_file.sqs_handler.output_base64sha256

  event_source_mappings = {
    HubSpot = {
      event_source_arn = aws_sqs_queue.HubSpot.arn

      // optionally overwrite function_name in case an alias should be used in the
      // event source mapping, see https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html
      // function_name    = aws_lambda_alias.example.arn

      // optionally overwrite arguments from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping
      batch_size = 5

      scaling_config = {
        maximum_concurrency = 2
      }

      // Lambda event filtering, see https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventfiltering.html
      filter_criteria = [
        {
          pattern = jsonencode({
            body : {
              Key1 : ["Value1"]
            }
          })
        },
        {
        }
      ]
    }
    HubSpot = {
      event_source_arn = aws_sqs_queue.HubSpot.arn
    }
  }
}
