data "aws_caller_identity" "current" {}

resource "aws_lambda_permission" "allow_api" {
  statement_id  = "AllowAPIgatewayInvokation"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.self.function_name
  principal     = "apigateway.amazonaws.com"
}


resource "aws_api_gateway_rest_api" "self" {
  api_key_source = "HEADER"
  disable_execute_api_endpoint = false
  name = var.project_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "self" {
  rest_api_id = aws_api_gateway_rest_api.self.id
  parent_id = aws_api_gateway_rest_api.self.root_resource_id
  path_part = "{proxy+}"
}

resource "aws_api_gateway_method" "any" {
  rest_api_id = aws_api_gateway_rest_api.self.id
  resource_id = aws_api_gateway_resource.self.id
  http_method = "ANY"
  authorization = "NONE"
  api_key_required = false
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.self.id
  resource_id             = aws_api_gateway_resource.self.id
  http_method             = aws_api_gateway_method.any.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.self.invoke_arn
}

resource "aws_api_gateway_stage" "self" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.self.id
  stage_name    = "api"
}

resource "aws_api_gateway_method_settings" "all" {
  rest_api_id = aws_api_gateway_rest_api.self.id
  stage_name  = aws_api_gateway_stage.self.stage_name
  method_path = "*/*"

  settings {
    caching_enabled = true
    throttling_rate_limit = 500
  }
}

resource "aws_api_gateway_method" "options" {
  rest_api_id = aws_api_gateway_rest_api.self.id
  resource_id = aws_api_gateway_resource.self.id
  http_method = "OPTIONS"
  authorization = "NONE"
  api_key_required = false
  request_parameters = {
  }
}
resource "aws_api_gateway_method_response" "response_200_options" {
  rest_api_id = aws_api_gateway_rest_api.self.id
  resource_id = aws_api_gateway_resource.self.id
  http_method = aws_api_gateway_method.options.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration" "integration_options" {
  rest_api_id             = aws_api_gateway_rest_api.self.id
  resource_id             = aws_api_gateway_resource.self.id
  http_method             = aws_api_gateway_method.options.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.self.id
    triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.self.body))
  }
  depends_on = [aws_api_gateway_integration.integration,
                aws_api_gateway_integration.integration_options,
                aws_api_gateway_method_response.response_200_options,
                aws_api_gateway_method.any,
                aws_api_gateway_method.options,
                aws_api_gateway_resource.self]
  lifecycle {
    create_before_destroy = true
  }
}