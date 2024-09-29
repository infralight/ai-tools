resource "aws_instance" "ip-10-5-197-40ec2internal" {
  ami                         = "ami-0cc12556e85f93d9a"
  associate_public_ip_address = false
  availability_zone           = "us-east-1a"
  cpu_core_count              = 4
  cpu_threads_per_core        = 1
  disable_api_termination     = false
  ebs_optimized               = false
  enclave_options {
    enabled = false
  }
  hibernation                          = false
  iam_instance_profile                 = aws_iam_instance_profile.backend-cluster_13105400894515674494.name
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "m7a.xlarge"
  metadata_options {
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }
  monitoring = false
  private_ip = "10.5.197.40"
  root_block_device {
    iops = 3000
    tags = {
      "firefly.ai/cluster"                    = "backend-cluster"
      "karpenter.k8s.aws/ec2nodeclass"        = "private-small"
      "karpenter.sh/discovery"                = "backend-cluster"
      "karpenter.sh/managed-by"               = "backend-cluster"
      "karpenter.sh/nodepool"                 = "reserved-private-amd64-static-small-m7a"
      "kubernetes.io/cluster/backend-cluster" = "owned"
    }
    throughput  = 125
    volume_size = 50
    volume_type = "gp3"
  }
  secondary_private_ips = ["10.5.192.48", "10.5.195.174", "10.5.197.219", "10.5.197.55", "10.5.198.238", "10.5.200.124", "10.5.200.129", "10.5.200.197", "10.5.201.90", "10.5.203.22", "10.5.204.135", "10.5.205.122", "10.5.205.51", "10.5.206.122"]
  subnet_id             = aws_subnet.us-east-1-prod-1-private-backend-cluster-0.id
  tags = {
    Name                                    = "ip-10-5-197-40.ec2.internal"
    "firefly.ai/cluster"                    = "backend-cluster"
    "karpenter.k8s.aws/ec2nodeclass"        = "private-small"
    "karpenter.sh/discovery"                = "backend-cluster"
    "karpenter.sh/managed-by"               = "backend-cluster"
    "karpenter.sh/nodeclaim"                = "reserved-private-amd64-static-small-m7a-r8fz8"
    "karpenter.sh/nodepool"                 = "reserved-private-amd64-static-small-m7a"
    "kubernetes.io/cluster/backend-cluster" = "owned"
  }
  tenancy                = "default"
  vpc_security_group_ids = [aws_security_group.eks-cluster-sg-backend-cluster-2046285887.id]
  # The following attributes have default values introduced when importing the resource into terraform: [timeouts]
  lifecycle {
    ignore_changes = [timeouts]
  }
}


resource "aws_iam_instance_profile" "backend-cluster_13105400894515674494" {
  name = "backend-cluster_13105400894515674494"
  role = "Karpenter-backend-cluster-2024052214295913240000000d"
  tags = {
    "firefly.ai/cluster"                    = "backend-cluster"
    "karpenter.k8s.aws/ec2nodeclass"        = "private-small"
    "karpenter.sh/discovery"                = "backend-cluster"
    "karpenter.sh/managed-by"               = "backend-cluster"
    "kubernetes.io/cluster/backend-cluster" = "owned"
    "topology.kubernetes.io/region"         = "us-east-1"
  }
}


resource "aws_network_interface" "eni-07b1670149c2406d6" {
  attachment {
    instance = aws_instance.ip-10-5-197-40ec2internal.id
  }
  private_ip        = "10.5.197.40"
  private_ips       = ["10.5.192.48", "10.5.195.174", "10.5.197.219", "10.5.197.40", "10.5.197.55", "10.5.198.238", "10.5.200.124", "10.5.200.129", "10.5.200.197", "10.5.201.90", "10.5.203.22", "10.5.204.135", "10.5.205.122", "10.5.205.51", "10.5.206.122"]
  private_ips_count = 14
  security_groups   = [aws_security_group.eks-cluster-sg-backend-cluster-2046285887.id]
  subnet_id         = aws_subnet.us-east-1-prod-1-private-backend-cluster-0.id
  tags = {
    "cluster.k8s.amazonaws.com/name"        = "backend-cluster"
    "firefly.ai/cluster"                    = "backend-cluster"
    "karpenter.k8s.aws/ec2nodeclass"        = "private-small"
    "karpenter.sh/discovery"                = "backend-cluster"
    "karpenter.sh/managed-by"               = "backend-cluster"
    "karpenter.sh/nodepool"                 = "reserved-private-amd64-static-small-m7a"
    "kubernetes.io/cluster/backend-cluster" = "owned"
    "node.k8s.amazonaws.com/instance_id"    = aws_instance.ip-10-5-197-40ec2internal.id
  }
}


resource "aws_security_group" "eks-cluster-sg-backend-cluster-2046285887" {
  description = "EKS created security group applied to ENI that is attached to EKS Control Plane master nodes, as well as any managed workloads."
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  ingress {
    from_port = 0
    protocol  = "-1"
    self      = true
    to_port   = 0
  }
  ingress {
    description     = "elbv2.k8s.aws/targetGroupBinding=shared"
    from_port       = 2746
    protocol        = "tcp"
    security_groups = ["sg-01854f6b36c9eb342"]
    to_port         = 9200
  }
  name = "eks-cluster-sg-backend-cluster-2046285887"
  tags = {
    Account                                 = "094724549126"
    Env                                     = "prod-2"
    Name                                    = "eks-cluster-sg-backend-cluster-2046285887"
    Region                                  = "us-east-1"
    Terraform                               = "v2"
    "karpenter.sh/discovery"                = "backend-cluster"
    "kubernetes.io/cluster/backend-cluster" = "owned"
  }
  vpc_id = aws_vpc.us-east-1-prod-2.id
  # The following attributes have default values introduced when importing the resource into terraform: [revoke_rules_on_delete timeouts]
  lifecycle {
    ignore_changes = [revoke_rules_on_delete, timeouts]
  }
}


resource "aws_subnet" "us-east-1-prod-1-private-backend-cluster-0" {
  cidr_block                          = "10.5.192.0/20"
  private_dns_hostname_type_on_launch = "ip-name"
  tags = {
    Name                                    = "us-east-1-prod-1-private-backend-cluster-0"
    Terraform                               = "v2"
    "karpenter.sh/discovery"                = "backend-cluster-private"
    "kubernetes.io/cluster/backend-cluster" = "shared"
    "kubernetes.io/role/internal-elb"       = "1"
    subnet_type                             = "private"
  }
  vpc_id = aws_vpc.us-east-1-prod-2.id
}


resource "aws_vpc" "us-east-1-prod-2" {
  cidr_block                     = "10.4.0.0/16"
  enable_classiclink_dns_support = false
  enable_dns_hostnames           = true
  tags = {
    Account   = "094724549126"
    Env       = "us-east-1-prod-2"
    Name      = "us-east-1-prod-2"
    Region    = "us-east-1"
    Terraform = "v2"
  }
}

