variable "subnet_ids" {
  description = "The list of subnet IDs for the RDS database subnet group."
  type        = list(string)
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

variable "identifier" {
  description = "The name of the database"
  type        = string   
  default = "my-db-instance"
}

variable "username" {
  description = "the username for admin"
  type        = string
  default = "root"
  
}

variable "password" {
  description = "The root password"
  type        = string
  default = "password"
  
}

variable "sg_ids" {
  description = "ids for rds sg"
  type        = list(string)
}