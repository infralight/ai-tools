resource "aws_iam_role" "self" {
  name = var.project_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
  EOF
}

resource "aws_iam_policy" "self" {
  name = var.project_name

  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
  EOF
}

resource "aws_iam_role_policy_attachment" "self" {
  role       = aws_iam_role.self.name
  policy_arn = aws_iam_policy.self.arn
}

resource "aws_lambda_function" "self" {
  function_name = var.project_name
  role          = aws_iam_role.self.arn


  package_type = "Image"
  image_uri    = "${aws_ecr_repository.self.repository_url}@${data.aws_ecr_image.service_image.image_digest}"
  environment {
    variables = var.environment_variables
  }
  timeout     = var.timeout
  memory_size = var.memory_size

  tracing_config {
    mode = "Active"
  }
}