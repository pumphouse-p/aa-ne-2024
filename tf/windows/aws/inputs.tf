variable "region" {
  type        = string
  description = "AWS region to deploy/destroy resources"
  default     = "us-east-2"
}

variable "instance_type" {
  type        = string
  description = "Type of instance(s) to deploy"
  default     = "m5.xlarge"
}

variable "key_name" {
  type        = string
  description = "Admin user encryption password"
  default     = "ansibleadmin-windows"
}

variable "instance_count" {
  type        = number
  description = "The number of instances that should be present"
  default     = 3
}
