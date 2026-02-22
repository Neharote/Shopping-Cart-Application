variable "public_subnet_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }
variable "jenkins_sg_id" { type = string }
variable "app_sg_id" { type = string }
variable "ami_id" { type = string }
variable "key_name" { type = string }
variable "instance_profile" { type = string }