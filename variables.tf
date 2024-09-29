variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "The AZ to start the instance in"
  type        = string
}

variable "cpu_core_count" {
  description = "The number of CPU cores for the instance"
  type        = number
}

variable "cpu_threads_per_core" {
  description = "The number of threads per CPU core"
  type        = number
  default     = 1
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "enclave_options_enabled" {
  description = "Whether Nitro Enclaves will be enabled on the instance"
  type        = bool
  default     = false
}

variable "hibernation" {
  description = "If true, the launched EC2 instance will support hibernation"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with"
  type        = string
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  type        = string
  default     = "stop"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "http_put_response_hop_limit" {
  description = "The desired HTTP PUT response hop limit for instance metadata requests"
  type        = number
  default     = 2
}

variable "http_tokens" {
  description = "Whether or not the metadata service requires session tokens"
  type        = string
  default     = "required"
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
}

variable "root_block_device_iops" {
  description = "The amount of provisioned IOPS for the root volume"
  type        = number
}

variable "root_block_device_tags" {
  description = "A map of tags to assign to the root block device"
  type        = map(string)
}

variable "root_block_device_throughput" {
  description = "The throughput to provision for the root volume in MiB/s"
  type        = number
}

variable "root_block_device_volume_size" {
  description = "The size of the root volume in gigabytes"
  type        = number
}

variable "root_block_device_volume_type" {
  description = "The type of volume for the root block device"
  type        = string
}

variable "secondary_private_ips" {
  description = "A list of secondary private IPv4 addresses to assign to the instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC)"
  type        = string
  default     = "default"
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
}
