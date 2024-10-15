variable "region" {
    type = string
    description = "AWS Region to deploy/destroy resources"
    default = "us-east-2"
}

variable "instance_type" {
    type = string
    description = "Type of instance to deploy"
    default = "t2.micro"
}

variable "key_name" {
    type = string
    description = "SSH key to inject into instances"
    default = "ansibleadmin"
}

variable "instance_count" {
    type = number
    description = "The number of instances that should be present"
    default = 1
}
