variable memory_size {
  type        = number
  default     = 128
  description = "lambda memory"
}

variable timeout {
  type        = number
  default     = 30
  description = "timeout"
}

variable lambda_handler {
  type        = string
  description = "lambda handler"
}

variable environment_variables {
  type        = map(string)
  default = {}
}


variable region {
  type        = string
  description = "Region"
}

variable "project_name" {
  type        = string
  description = "project name"
}