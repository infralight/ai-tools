resource "aws_instance" "ec2_instance" {
  ami                         = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone
  cpu_core_count              = var.cpu_core_count
  cpu_threads_per_core        = var.cpu_threads_per_core
  disable_api_termination     = var.disable_api_termination
  ebs_optimized               = var.ebs_optimized
  enclave_options {
    enabled = var.enclave_options_enabled
  }
  hibernation                          = var.hibernation
  iam_instance_profile                 = var.iam_instance_profile
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  instance_type                        = var.instance_type
  metadata_options {
    http_put_response_hop_limit = var.http_put_response_hop_limit
    http_tokens                 = var.http_tokens
  }
  monitoring         = var.monitoring
  private_ip         = var.private_ip
  root_block_device {
    iops        = var.root_block_device_iops
    tags        = var.root_block_device_tags
    throughput  = var.root_block_device_throughput
    volume_size = var.root_block_device_volume_size
    volume_type = var.root_block_device_volume_type
  }
  secondary_private_ips = var.secondary_private_ips
  subnet_id             = var.subnet_id
  tags                  = var.tags
  tenancy               = var.tenancy
  vpc_security_group_ids = var.vpc_security_group_ids

  lifecycle {
    ignore_changes = [timeouts]
  }
}
