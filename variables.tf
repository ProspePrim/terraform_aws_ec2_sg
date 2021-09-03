#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "practice"
}

variable "instance_tenancy" {
    description = "instance tenancy"
    default     = "default"
}

variable "environment" {
    description = "Environment for service"
    default     = "practice"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "availability_zone" {
  default = "us-west-2"
}

variable "aws_access_key" {
  description = "Your aws access key"
}

variable "aws_secret_key" {
  description = "Your aws secret key"
}

variable "my_ip_address" {
  description = "My white ip address"
}

#---------------------------------------------------------------
# Tags
#---------------------------------------------------------------

variable "data_creation" {
    description = "Data creation"
    default     = "9/2/2021"
}

variable "your_first_name" {
    description = "first name"
    default     = "Artyom"
}

variable "your_last_name" {
    description = "last name"
    default     = "Prima"
}

variable "aws_account_id" {
    description = "account id"
    default     = "263199259485"
}

#---------------------------------------------------------------
# SG variables
#---------------------------------------------------------------
variable "vpc" {
  description  = "VPC id"
  default      = "vpc-dcc9c9a4"
}

variable "allowed_ports" {
  description = "Allowed ports from/to host"
  type        = list
  default     = ["22", "80", "443", "8080", "8443"]
}

variable "enable_all_egress_ports" {
    description = "Allows all ports from host"
    default     = false
}

#---------------------------------------------------------------
# SG variables
#---------------------------------------------------------------

variable "number_of_instances" {
    description = "Number of instances"
    default     = "1"
}

variable "ami_id" {
    description = "AMI id"
    default     = "ami-083ac7c7ecf9bb9b0"
}

variable "ec2_instance_type" {
    description = "Instance Type"
    default     = "t2.micro"
}

variable "disk_size" {
    description = "Disk size"
    default     = "10"
}

