# Setup our aws provider
variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name for the VPC Gateway"
  default     = "project-eks-vpc"
}


variable "internet_gateway_name" {
  description = "Name for the Internet Gateway"
  default     = "igw"
}

variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    tag_name          = string
  }))
  default = {
    "subnet-1" = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      tag_name          = "public-subnet-1a"
    },
    "subnet-2" = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      tag_name          = "public-subnet-1b"
    },
  }
}

variable "private_subnets" {
  description = "Map of private subnets"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    tag_name          = string
  }))
  default = {
    "subnet-3" = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1a"
      tag_name          = "private-subnet-1a"
    },
    "subnet-4" = {
      cidr_block        = "10.0.4.0/24"
      availability_zone = "us-east-1b"
      tag_name          = "private-subnet-1b"
    },
  }
}


variable "db_subnets" {
  description = "Map of private subnets"
  type        = map(object({
    cidr_block        = string
    availability_zone = string
    tag_name          = string
  }))
  default = {
    "subnet-5" = {
      cidr_block        = "10.0.5.0/24"
      availability_zone = "us-east-1a"
      tag_name          = "private-subnet-1a"
    },
    "subnet-6" = {
      cidr_block        = "10.0.6.0/24"
      availability_zone = "us-east-1b"
      tag_name          = "private-subnet-1b"
    },
  }
}

variable "ami_id" {
  description = "Name of Launch configuration"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Name of Launch configuration"
  type        = string
  default     = ""
}

variable "db_username" {
  description = "Name of Launch configuration"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Name of Launch configuration"
  type        = string
  default     = ""
}

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  default     = "am-ecs-cluster"  
}

variable "sqs_queue_name" {
  description = "SQS Queue Name"
  default     = "am-sqs-queue"  
}