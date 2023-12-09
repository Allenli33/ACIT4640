variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "project_name" {
  description = "Project name"
  default = "a03"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "192.168.0.0/16"
}

variable "web_subnet_cidr" {
  description = "Subnet CIDR"
  default     = "192.168.2.0/24"
}

variable "be_subnet_cidr" {
  description = "Subnet CIDR"
  default     = "192.168.1.0/24"
}

variable "db1_subnet_cidr" {
  description = "Subnet CIDR"
  default     = "192.168.3.0/24"
}

variable "db2_subnet_cidr" {
  description = "Subnet CIDR"
  default     = "192.168.4.0/24"
}

variable "default_route"{
  description = "Default route"
  default     = "0.0.0.0/0"
}

variable "home_net" {
  description = "Home network"
  default     = "216.71.208.109/32"
}

variable "bcit_net" {
  description = "BCIT network"
  default     = "142.232.0.0/16"
  
}

variable "ami_id" {
  description = "AMI ID"
}

variable "ssh_key_name"{
  description = "AWS SSH key name"
  default = "acit_4640"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes for the RDS instance."
  type        = number
  default     = 5
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance."
  default     = "db.t2.micro"
}
